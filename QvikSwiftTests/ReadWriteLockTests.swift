//
//  ReadWriteLockTests.swift
//  QvikSwift
//
//  Created by Matti Dahlbom on 12.8.201533.
//  Copyright (c) 2015 Qvik. All rights reserved.
//

import Foundation
import XCTest

class ReadWriteLockTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReadLocking() {
        let lock = ReadWriteLock()
        let res1 = lock.tryLockToRead()
        let res2 = lock.tryLockToRead()
        let res3 = lock.tryLockToWrite()
        
        XCTAssert(res1)
        XCTAssert(res2)
        XCTAssert(!res3)
        
        lock.unlock()
        lock.unlock()
    }
    
    func testWriteLocking() {
        let lock = ReadWriteLock()
        let res1 = lock.tryLockToWrite()
        let res2 = lock.tryLockToRead()
        let res3 = lock.tryLockToWrite()
        
        XCTAssert(res1)
        XCTAssert(!res2)
        XCTAssert(!res3)
        
        lock.unlock()
    }
}

