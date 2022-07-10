//
//  Resources.swift
//  CIFilterPlayground
//
//  Created by Egor Butyrin on 06.04.2022.
//

import Foundation

enum Resources {
    enum URLs {
        static var sampleImage1: URL {
            Bundle.main.url(forResource: "sample1", withExtension: "jpeg")!
        }
        static var sampleImage2: URL {
            Bundle.main.url(forResource: "sample2", withExtension: "jpeg")!
        }
    }
}
