//
//  RandomImageViewModel.swift
//  LiveCoding
//
//  Created by kjs on 04/10/23.
//

import Foundation
import Combine

final class RandomImageViewModel: ObservableObject {
    private let provider = RandomImageProvider()
    private let provider2 = ImageProcessor()
    private var cancelBag = Set<AnyCancellable>()

    @Published var result: ImageData = .init()
    @Published var error = Error?.none

    func input(_ viewEvent: ViewEvent) {
        switch viewEvent {
        case .onAppear:
            provider.input()
                .receive(on: DispatchQueue.main)
                .sink { result in
                    switch result {
                    case .success(let imageData):
                        self.result = imageData
                    case .failure(let error):
                        self.error = error
                    }
                }
                .store(in: &cancelBag)
        case .buttonTouch:
            provider2.input()
                .receive(on: DispatchQueue.main)
                .sink { result in
                    switch result {
                    case .success(let imageData):
                        self.result = imageData
                    case .failure(let error):
                        self.error = error
                    }
                }
                .store(in: &cancelBag)
        }
    }
}
