// The Swift Programming Language
import Foundation
import Combine

public enum MyNetworkError: Error {
    case redircet
    case clinetError(code: Int, description: String)
    case serverError(code: Int, description: String)
    case dataIsEmpty
    case responseIsNotProper
}

public final class Networker {
    public init() { }

    public func request(_ url: URL) -> AnyPublisher<Result<Data, Error>, Never> {
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { (data, response) -> Result<Data, Error> in
                guard let response = response as? HTTPURLResponse else {
                    return .failure(MyNetworkError.responseIsNotProper)
                }

                switch response.statusCode {
                case 300...400:
                    return .failure(MyNetworkError.redircet)
                case 400...500:
                    return .failure(MyNetworkError.clinetError(code: response.statusCode, description: response.description))
                case 500...:
                    return .failure(MyNetworkError.serverError(code: response.statusCode, description: response.description))
                default:
                    break
                }

                if data.count == .zero {
                    return .failure(MyNetworkError.dataIsEmpty)
                } else {
                    return .success(data)
                }
            }
            .catch { error in
                return Just(Result.failure(error))
            }
            .eraseToAnyPublisher()
    }
}
