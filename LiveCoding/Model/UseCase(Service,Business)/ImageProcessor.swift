//
//  ImageProcessor.swift
//  LiveCoding
//
//  Created by kjs on 04/10/23.
//

import Combine
import CoreGraphics
import Foundation

struct ImageProcessor {
    private let provider = RandomImageProvider()

    func input() -> AnyPublisher<Result<ImageData, Error>, Never> {
        provider.input()
            .map { result -> Result<ImageData, Error> in
                switch result {
                case .success(let imageData):
                    let imageData = self.grayScaled(imageData)
                    return .success(imageData)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }

    private func grayScaled(_ image: ImageData) -> ImageData {
        let width = image.size.width
        let height = image.size.height
        let imgRect = CGRect(x: 0, y: 0, width: width, height: height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let cgImage = image.cgImage

        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue).rawValue)
        context?.draw(cgImage!, in: imgRect)

        let imageRef = context!.makeImage()
        let newImg = ImageData(cgImage: imageRef!)

        return newImg
    }
}
