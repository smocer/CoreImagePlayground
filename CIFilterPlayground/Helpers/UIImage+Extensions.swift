//
//  UIImage+Extensions.swift
//  CIFilterPlayground
//
//  Created by Egor Butyrin on 10.07.2022.
//

import UIKit

extension UIImage {

    enum Axis {
        case horizontal, vertical
    }

    // creates a static image with a gradient of colors of the requested size
    static func makeGradient(colors: [UIColor], locations: [CGFloat], axis: Axis, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let cgColors = colors.map { $0.cgColor } as CFArray
        let grad = CGGradient(colorsSpace: colorSpace, colors: cgColors , locations: locations)

        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = axis == .horizontal ? CGPoint(x: size.width, y: 0) : CGPoint(x: 0, y: size.height)

        context?.drawLinearGradient(grad!, start: startPoint, end: endPoint, options: .drawsAfterEndLocation)

        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
