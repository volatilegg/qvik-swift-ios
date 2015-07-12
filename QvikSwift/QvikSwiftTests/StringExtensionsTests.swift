//
//  StringExtensionsTests.swift
//  QvikSwift
//
//  Created by Matti Dahlbom on 12.7.201528.
//  Copyright (c) 2015 Qvik. All rights reserved.
//

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
    
    func testContains() {
        let subs = "foo"
        let s1 = "Hello, world, this is foo bar!"
        let s2 = "Oh fo oo"
        XCTAssert(s1.contains(subs))
        XCTAssert(!s2.contains(subs))
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
        XCTAssert(count(parts1) == 3, "Invalid part count")
        XCTAssert(parts1[0] == "123")
        XCTAssert(parts1[1] == "abc")
        XCTAssert(parts1[2] == "def")
        let s2 = "1234567"
        let parts2 = s2.splitEqually(length: 2)
        XCTAssert(count(parts2) == 4, "Invalid part count")
        XCTAssert(parts2[0] == "12")
        XCTAssert(parts2[1] == "34")
        XCTAssert(parts2[2] == "56")
        XCTAssert(parts2[3] == "7")
    }
}
