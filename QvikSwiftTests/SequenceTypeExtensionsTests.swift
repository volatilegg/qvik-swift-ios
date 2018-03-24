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

    func testUnique() {
        let ints = [0, 1, 2, 3, 3, 4, 2, 5, 10, 11, 5, 12, 12, 23, 15, 23]
        let uniqueInts = [0, 1, 2, 3, 4, 5, 10, 11, 12, 23, 15]
        XCTAssert(ints.unique() == uniqueInts)

        let strings = ["kalle", "palle", "jarkko", "kerkko", "kalle", "kissa", "palle", "kerkko"]
        let uniqueStrings = ["kalle", "palle", "jarkko", "kerkko", "kissa"]
        XCTAssert(strings.unique() == uniqueStrings)
    }
}
