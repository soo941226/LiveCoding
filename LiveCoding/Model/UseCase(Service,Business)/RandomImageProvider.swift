//
//  RandomImageProvider.swift
//  LiveCoding
//
//  Created by kjs on 04/10/23.
//

import Foundation
import Networker
import Combine

final class RandomImageProvider {
    private let urlString = "https://picsum.photos/200/300"
    private let networker = Networker()

    func input() -> AnyPublisher<Result<ImageData, Error>, Never> {
        guard let url = URL(string: urlString) else {
            return Just(Result.failure(MyError.urlIsNotFit))
                .eraseToAnyPublisher()
        }

        return networker.request(url)
            .map { (result) -> Result<ImageData, Error> in
                switch result {
                case .success(let data):
                    guard let imageData = ImageData(data: data) else {
                        return .failure(MyError.dataIsNotFit)
                    }

                    return .success(imageData)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
