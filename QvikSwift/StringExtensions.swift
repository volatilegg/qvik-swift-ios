//
//  StringExtensions.swift
//  QvikSwift
//
//  Created by Matti Dahlbom on 12.7.2015.
//  Copyright (c) 2015 Qvik. All rights reserved.
//

import Foundation

import Foundation

/// Extensions to the String class.
extension String {
    /**
    Adds a read-only length property to String.
    
    :returns: String length in number of characters.
    */
    public var length: Int {
        return count(self)
    }
    
    /**
    Checks whether the string contains a given substring.
    
    :param: s substring to check for
    :returns: true if this string contained the given substring, false otherwise.
    */
    public func contains(s: String) -> Bool {
        return (self.rangeOfString(s) != nil)
    }
    
    /**
    Returns a substring of this string from a given index up the given length.
    
    :param: startIndex index of the first character to include in the substring
    :param: length number of characters to include in the substring
    :returns: the substring
    */
    public func substring(#startIndex: Int, length: Int) -> String {
        let start = advance(self.startIndex, startIndex)
        let end = advance(self.startIndex, startIndex + length)
        
        return self[start..<end]
    }
    
    /**
    Returns a substring of this string from a given index to the end of the string.
    
    :param: startIndex index of the first character to include in the substring
    :returns: the substring from startIndex to the end of this string
    */
    public func substring(#startIndex: Int) -> String {
        let start = advance(self.startIndex, startIndex)
        return self[start..<self.endIndex]
    }
    
    /**
    Splits the string into substring of equal 'lengths'; any remainder string
    will be shorter than 'length' in case the original string length was not multiple of 'length'.
    
    :param: length (max) length of each substring
    :returns: the substrings array
    */
    public func splitEqually(#length: Int) -> [String] {
        var index = 0
        let len = self.length
        var strings: [String] = []
        
        while index < len {
            let numChars = min(length, (len - index))
            strings.append(self.substring(startIndex: index, length: numChars))
            
            index += numChars
        }
        
        return strings
    }
}