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

import UIKit
import XCTest

class StringExtensionsTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLength() {
        let s = "hello, world"
        XCTAssert(s.length == 12)
        let s2 = "abc123"
        XCTAssert(s2.length == 6)
    }
    
    func testUrlEncoding() {
        let s = "foo bar kek! bur & diu : dau"
        let encoded = s.urlEncoded
        XCTAssert(encoded == "foo%20bar%20kek!%20bur%20&%20diu%20:%20dau")
    }
    
    func testContains() {
        let subs = "foo"
        let s1 = "Hello, world, this is foo bar!"
        let s2 = "Oh fo oo"
        XCTAssert(s1.contains(subs))
        XCTAssert(!s2.contains(subs))
    }
    
    func testSplit() {
        let string = "123 4567 abcdef"
        let split = string.split(" ")
        XCTAssert(split[0] == "123")
        XCTAssert(split[1] == "4567")
        XCTAssert(split[2] == "abcdef")
    }
    
    func testSubstring() {
        let expected1 = " cat"
        let s1 = "A dog, cat and mouse had a party."
        XCTAssert(s1.substring(startIndex: 6, length: 4) == expected1)
        let expected2 = "the world."
        let s2 = "It's the end of the world."
        XCTAssert(s2.substring(startIndex: 16) == expected2)
    }
    
    func testSplitEqually() {
        let s1 = "123abcdef"
        let parts1 = s1.splitEqually(length: 3)
        XCTAssert(parts1.count == 3, "Invalid part count")
        XCTAssert(parts1[0] == "123")
        XCTAssert(parts1[1] == "abc")
        XCTAssert(parts1[2] == "def")
        let s2 = "1234567"
        let parts2 = s2.splitEqually(length: 2)
        XCTAssert(parts2.count == 4, "Invalid part count")
        XCTAssert(parts2[0] == "12")
        XCTAssert(parts2[1] == "34")
        XCTAssert(parts2[2] == "56")
        XCTAssert(parts2[3] == "7")
    }
}
