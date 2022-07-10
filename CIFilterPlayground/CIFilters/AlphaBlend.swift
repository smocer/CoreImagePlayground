//
//  FilterAlphaBlend.swift
//  CIFilterPlayground
//
//  Created by Egor Butyrin on 06.04.2022.
//

import Foundation
import CoreImage
import UIKit

final class AlphaBlend {

    private lazy var grayMask: CIImage = {
        let grayGenerator = CIFilter(name: "CIConstantColorGenerator")!
        let gray05alpha = CIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        grayGenerator.setValue(gray05alpha, forKey: kCIInputColorKey)
        return grayGenerator.outputImage!
    }()
    private let alphaBlend = CIFilter(name: "CIBlendWithAlphaMask")!

    lazy var sampleImage1: CIImage? = {
        return CIImage(contentsOf: Resources.URLs.sampleImage1)
    }()

    lazy var sampleImage2: CIImage? = {
        return CIImage(contentsOf: Resources.URLs.sampleImage2)
    }()

    func render() -> UIImage {
        alphaBlend.setValue(sampleImage1, forKey: kCIInputBackgroundImageKey)
        alphaBlend.setValue(sampleImage2, forKey: kCIInputImageKey)
        alphaBlend.setValue(grayMask, forKey: kCIInputMaskImageKey)
        let ctx = CIContext()
        let cgImage = ctx.createCGImage(alphaBlend.outputImage!, from: CGRect(origin: .zero, size: .square(512)))!
        return UIImage(cgImage: cgImage)
    }

}
