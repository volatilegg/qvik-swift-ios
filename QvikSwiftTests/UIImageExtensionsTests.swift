//
//  UIImageExtensionsTests.swift
//  QvikSwift
//
//  Created by Matti Dahlbom on 12.7.201528.
//  Copyright (c) 2015 Qvik. All rights reserved.
//

import Foundation
import UIKit
import XCTest

class UIImageExtensionsTests: XCTestCase {
    private let imageWidth = 400
    private let imageHeight = 300
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func createImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth, height: imageHeight), false, 1.0)
        let blankImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return blankImage
    }
    
    func testScaleDown() {
        let image = createImage()
        let scaledDown = image.scaleDown(maxSize: CGSize(width: 200, height: 150))
        XCTAssert(scaledDown.size.width == 200)
        XCTAssert(scaledDown.size.height == 150)
    }
    
    func testCrop() {
        let image = createImage()
        let cropped = image.cropImageToSquare()
        let diff = abs(cropped.width - cropped.height)
        XCTAssert(diff <= 1, "Cropped image is not roughly a square!")
    }
}
