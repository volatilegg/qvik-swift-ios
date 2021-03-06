// The MIT License (MIT)
//
// Copyright (c) 2015 Qvik (www.qvik.fi)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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
    
    func testImageWithNormalizedOrientation() {
        let image = createImage()
        let normalized = image.imageWithNormalizedOrientation()
        
        XCTAssert(image.width == normalized.width)
        XCTAssert(image.height == normalized.height)
        XCTAssert(normalized.imageOrientation == .Up)
    }
    
    func testScaleDown() {
        let image = createImage()
        let scaledDown = image.scaleDown(maxSize: CGSize(width: 200, height: 150))
        XCTAssert(scaledDown.size.width == 200)
        XCTAssert(scaledDown.size.height == 150)
    }
    
    func testScale() {
        let scaledSize = CGSize(width: 55, height: 66)
        let image = createImage()
        let scaled = image.scaleTo(size: scaledSize)
        XCTAssert(scaled.scale == 1.0)
        XCTAssert(scaled.size.width == scaledSize.width)
        XCTAssert(scaled.size.height == scaledSize.height)
    }

    func testScaleToFit() {
        let maxSize = CGSize(width: 77, height: 88)
        let image = createImage()
        let scaled1 = image.scaleToFit(sizeToFit: maxSize, imageScale: 1.0)
        let scaled2 = image.scaleToFit(sizeToFit: maxSize, imageScale: 2.0)
        let origAspect = image.width / image.height
        XCTAssert(scaled1.scale == 1.0)
        let aspect1 = scaled1.width / scaled1.height
        XCTAssert(abs(aspect1 - origAspect) < 0.01)
        XCTAssert(scaled1.scale == 1.0)
        let aspect2 = scaled2.width / scaled2.height
        XCTAssert(abs(aspect2 - origAspect) < 0.01)
        XCTAssert(scaled2.scale == 2.0)
    }
    
    func testCrop() {
        let image = createImage()
        let cropped = image.cropImageToSquare()
        let diff = abs(cropped.width - cropped.height)
        XCTAssert(diff <= 1, "Cropped image is not roughly a square!")
    }
    
    func testBlur() {
        let image = createImage()
        let blurred = image.blur(radius: 5.0, algorithm: .TentConvolve)
        XCTAssert(image.width == blurred.width)
        XCTAssert(image.height == blurred.height)
    }
}
