// The MIT License (MIT)
//
// Copyright (c) 2016 Qvik (www.qvik.fi)
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

/**
 A generic keychain wrapper utility. For information on the keychain concept, see:
 `https://developer.apple.com/library/content/documentation/Security/Conceptual/keychainServConcepts/02concepts/concepts.html`
 */
open class Keychain {
    private let serviceName: String
    private let accessMode: String
    private var accessGroup: String?

    /// Errors generated by the methods in this class.
    public enum Errors: Error {
        case apiCallFailed(statusCode: OSStatus)
        case conversionError
    }

    /**
     Constructs the wrapper. 
     
     - parameter serviceName: Name for your 'service' using the keychain; eg. com.company.MyApp
     - parameter accessMode: One of:
       - `kSecAttrAccessibleWhenUnlocked`
       - `kSecAttrAccessibleAfterFirstUnlock`
       - `kSecAttrAccessibleAlways`
       - `kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly`
       - `kSecAttrAccessibleWhenUnlockedThisDeviceOnly`
       - `kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly`
       - `kSecAttrAccessibleAlwaysThisDeviceOnly`
     - parameter accessGroup: Name for an access group. Access groups can be used to share keychain items among two or more applications. Optional.
     */
    public init(serviceName: String, accessMode: String, accessGroup: String? = nil) {
        self.serviceName = serviceName
        self.accessMode = accessMode
        self.accessGroup = accessGroup
    }

    /**
     Creates the common attribute/query structure used in all the access methods.
     
     - returns: The attribute array for accessing underlying keychain
     */
    private func createParams(forKey key: String) -> [String: Any] {
        var attributes: [String: Any] = [
            kSecClass as String: (kSecClassGenericPassword as String),
            kSecAttrAccessible as String: self.accessMode,
            kSecAttrService as String: self.serviceName,
            kSecAttrAccount as String: key
        ]

        if let accessGroup = self.accessGroup {
            attributes[kSecAttrAccessGroup as String] = accessGroup
        }

        return attributes
    }

    /**
     Adds a new key to the keychain. 
     
     - parameter key: a string key
     - parameter value: a string value
     - throws: Errors.apiCallFailed if the API call fails
     */
    open func add(key: String, value: String) throws {
        guard let valueData = value.data(using: .utf8) else {
            throw Errors.conversionError
        }

        var attributes = createParams(forKey: key)
        attributes[kSecValueData as String] = valueData

        let status = SecItemAdd(attributes as CFDictionary, nil)

        if status != errSecSuccess {
            throw Errors.apiCallFailed(statusCode: status)
        }
    }

    /**
     Updates the value for a key.

     - parameter key: a string key
     - parameter newValue: new value for the key
     - throws: Errors.apiCallFailed if the API call fails
     */
    open func update(key: String, newValue: String) throws {
        let query = createParams(forKey: key)
        let newAttributes = [kSecValueData as String: newValue]

        let status = SecItemUpdate(query as CFDictionary, newAttributes as CFDictionary)

        if status != errSecSuccess {
            throw Errors.apiCallFailed(statusCode: status)
        }
    }

    /**
     Removes a key (and its value) from the keychain. 

     - parameter key: a string key
     - throws: Errors.apiCallFailed if the API call fails
     */
    open func remove(key: String) throws {
        let query = createParams(forKey: key)

        let status = SecItemDelete(query as CFDictionary)

        if status != errSecSuccess {
            throw Errors.apiCallFailed(statusCode: status)
        }
    }

    /**
     Returns the (String) value for the given key, or nil if the key was not found.

     - parameter key: a string key
     - throws: Errors.apiCallFailed if the API call fails
     - returns: Value for the given key or nil if not found.
     */
    open func get(key: String) throws -> String? {
        var query = createParams(forKey: key)
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        if status != errSecSuccess {
            if status == errSecItemNotFound {
                return nil
            } else {
                throw Errors.apiCallFailed(statusCode: status)
            }
        }

        guard let valueData = result as? Data else {
            throw Errors.conversionError
        }

        let value = String(data: valueData, encoding: .utf8)

        return value
    }
}