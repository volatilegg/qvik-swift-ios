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
    
    func testBlur() {
        let image = createImage()
        let blurred = image.blur(radius: 5.0, algorithm: .TentConvolve)
        XCTAssert(image.width == blurred.width)
        XCTAssert(image.height == blurred.height)
    }
}
