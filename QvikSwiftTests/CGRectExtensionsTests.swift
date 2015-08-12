//
//  CGRectExtensionsTests.swift
//  QvikSwift
//
//  Created by Matti Dahlbom on 12.8.201533.
//  Copyright (c) 2015 Qvik. All rights reserved.
//

import UIKit
import XCTest

class CGRectExtensionsTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testScale() {
        let rect = CGRect(x: 5, y: 10, width: 20, height: 20)
        let scaled = rect.scaled(x: 2, y: 2)
        
        XCTAssert(scaled.minX == -5)
        XCTAssert(scaled.minY == 0)
        XCTAssert(scaled.width == 40)
        XCTAssert(scaled.height == 40)
    }
}