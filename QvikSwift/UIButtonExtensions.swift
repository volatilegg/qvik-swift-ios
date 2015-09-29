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

// obj association keys; this merely consumes minimal amount of space and
// provides per-process unique address to be used as the key
private var colorMapAssociationKey: UInt8 = 0

// Wraps a UInt -> UIColor dictionary in an object to remove the need to copy a dictionary around.
private class ColorMap {
    private var map = [UInt: UIColor]()
    
    subscript(index: UIControlState) -> UIColor? {
        get {
            return map[index.rawValue]
        }
        set {
            map[index.rawValue] = newValue
        }
    }
}

/// Extensions to the UIButton class
extension UIButton {
    // Returns the association object (UIControlState raw value -> color map), creating one if it doesnt exist
    private func getColorMap() -> ColorMap {
        if let map = objc_getAssociatedObject(self, &colorMapAssociationKey) as? ColorMap {
            return map
        } else {
            let map = ColorMap()
            objc_setAssociatedObject(self, &colorMapAssociationKey, map, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return map
        }
    }
    
    /**
    Sets a background color for a control state.
    
    - param color: new background color for the control state
    - param state: control state to set the color for
    */
    public func setBackgroundColor(color: UIColor, forControlState: UIControlState) {
        let map = getColorMap()
        map[forControlState] = color
        
        if state == forControlState {
            // This is the current control state; set the color immediately
            backgroundColor = color
        }
    }
    
    // Sets the background color for the current control state, if one is defined
    private func updateBackGroundColor() {
        let map = getColorMap()
        if let color = map[state] {
            backgroundColor = color
        } else if let color = map[UIControlState.Normal] {
            // Default to .Normal if color for current state is not set
            backgroundColor = color
        }
    }
    
    // Hooks into enabled to change background color accordingly
    override public var enabled: Bool {
        didSet {
            updateBackGroundColor()
        }
    }
    
    // Hooks into highlighted to change background color accordingly
    override public var highlighted: Bool {
        didSet {
            updateBackGroundColor()
        }
    }
    
    // Hooks into selected to change background color accordingly
    override public var selected: Bool {
        didSet {
            updateBackGroundColor()
        }
    }
}
