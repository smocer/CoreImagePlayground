//
//  ViewController.swift
//  CIFilterPlayground
//
//  Created by Egor Butyrin on 05.04.2022.
//

import UIKit

class ViewController: UIViewController {

    private let ciContext = CIContext()

    private let imagesWidth: CGFloat = 512//UIScreen.main.bounds.width

    override func loadView() {
        view = UIScrollView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.spacing = 8

        let col1 = UIColor(red: 247 / 255, green: 54 / 255, blue: 0 / 255, alpha: 1)
        let col2 = UIColor(red: 249 / 255, green: 203 / 255, blue: 34 / 255, alpha: 1)
        let gradientImage = UIImage.makeGradient(colors: [col1, col2], locations: [0, 0.81], axis: .horizontal, size: CGSize(width: imagesWidth, height: 1))

        vStack.addArrangedSubview(makeImageView(imageURL: Resources.URLs.sampleImage3))
        vStack.addArrangedSubview(makeGradientImageView(gradientImage: gradientImage))

        let filter = CustomColorMap()
        let inputImage = CIImage(contentsOf: Resources.URLs.sampleImage3)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        let gradient = CIImage(cgImage: gradientImage.cgImage!)
        filter.setValue(gradient, forKey: kCIInputGradientImageKey)

        vStack.addArrangedSubview(makeCIImageView(ciImage: filter.outputImage!))

        view.pinSubview(vStack)
    }

    private func makeImageView(imageURL: URL) -> UIImageView {
        let imageView = UIImageView(image: UIImage(contentsOfFile: imageURL.path))
        imageView.contentMode = .scaleAspectFit
        imageView.constrainSize(.square(imagesWidth))
        return imageView
    }

    private func makeGradientImageView(gradientImage: UIImage) -> UIImageView {
        let imageView = UIImageView(image: gradientImage)
        imageView.contentMode = .scaleToFill
        imageView.constrainSize(CGSize(width: imagesWidth, height: 32))
        return imageView
    }

    private func makeCIImageView(ciImage: CIImage) -> UIImageView {
        let imageView = UIImageView()
        let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent)
        imageView.image = UIImage(cgImage: cgImage!)
        imageView.contentMode = .scaleAspectFit
        imageView.constrainSize(.square(imagesWidth))
        return imageView
    }

}

