//
//  CGPointExtensionsTests.swift
//  QvikSwift
//
//  Created by Matti Dahlbom on 12.8.201533.
//  Copyright (c) 2015 Qvik. All rights reserved.
//

import UIKit
import XCTest

class CGPointExtensionsTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMiddlePoint() {
        let p1 = CGPoint(x: 256, y: 234)
        let p2 = CGPoint(x: -231, y: 879)
        let p3 = p1.middlePoint(p2)
        
        XCTAssert(p3.x == 12.5)
        XCTAssert(p3.y == 556.5)
    }
}

