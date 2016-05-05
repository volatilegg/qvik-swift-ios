//
//  SequenceTypeExtensions.swift
//  QvikSwift
//
//  Created by Matti Dahlbom on 05/05/16.
//  Copyright © 2016 Qvik. All rights reserved.
//

import Foundation

public extension SequenceType {
    /**
     Returns a unique set of values from the array, preserving order. Runs in O(N) complexity.

     - returns: array containing unique set of values from this sequence
     */
    public func unique<T: Hashable>() -> [T] {
        var valueSet = Set<T>()

        return flatMap { // O(N)
            guard let element = $0 as? T else {
                return nil
            }

            if !valueSet.contains(element) { // O(1), I hope
                valueSet.insert(element) // O(1), I hope
                return element
            } else {
                return nil
            }
        }
    }
}
