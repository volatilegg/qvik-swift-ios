//
//  SequenceTypeExtensionsTests.swift
//  QvikSwift
//
//  Created by Matti Dahlbom on 05/05/16.
//  Copyright © 2016 Qvik. All rights reserved.
//

import UIKit
import XCTest

class SequenceTypeExtensionsTests: XCTestCase {
    fileprivate let window = UIWindow()
    fileprivate let viewController = UIViewController()
    fileprivate let textView = UITextView()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        window.addSubview(viewController.view)
        viewController.view.addSubview(textView)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testUnique() {
        let ints = [0, 1, 2, 3, 3, 4, 2, 5, 10, 11, 5, 12, 12, 23, 15, 23]
        let uniqueInts = [0, 1, 2, 3, 4, 5, 10, 11, 12, 23, 15]
        XCTAssert(ints.unique() == uniqueInts)

        let strings = ["kalle", "palle", "jarkko", "kerkko", "kalle", "kissa", "palle", "kerkko"]
        let uniqueStrings = ["kalle", "palle", "jarkko", "kerkko", "kissa"]
        XCTAssert(strings.unique() == uniqueStrings)
    }
}
