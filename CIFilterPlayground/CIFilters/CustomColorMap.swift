//
//  CustomColorMap.swift
//  CIFilterPlayground
//
//  Created by Egor Butyrin on 10.07.2022.
//

import CoreImage
import simd

final class CustomColorMap: CIFilter {

    static let colorMapKernel = CIKernel(source: """
      kernel vec4 colorMapKernel(sampler src, sampler gradient) {
        vec4 imageColor = sample(src, samplerCoord(src));

        float grayscale = dot(imageColor.rgb, vec3(0.299, 0.587, 0.114));

        vec4 gradientColor = sample(gradient, vec2(grayscale, 0.));
        return gradientColor;
      }
      """
    )

    @objc dynamic var inputImage: CIImage?
    @objc dynamic var inputGradientImage: CIImage?

    override var attributes: [String : Any] {
      [
        kCIAttributeFilterDisplayName: "Custom colormap",
        kCIInputImageKey: [
          kCIAttributeIdentity: nil,
          kCIAttributeClass: "CIImage",
          kCIAttributeDisplayName: "Image",
          kCIAttributeType: kCIAttributeTypeImage
        ],
        kCIInputGradientImageKey: [
          kCIAttributeIdentity: nil,
          kCIAttributeClass: "CIImage",
          kCIAttributeDisplayName: "Gradient image",
          kCIAttributeType: kCIAttributeTypeImage
        ],
      ]
    }

    override var outputImage: CIImage? {
      get {
        guard let inputImage = inputImage else { return nil }

        return Self.colorMapKernel?.apply(
          extent: inputImage.extent,
          roiCallback: { _, rect in return rect },
          arguments: [
            inputImage as Any,
            inputGradientImage as Any
          ]
        )
      }
    }
}
