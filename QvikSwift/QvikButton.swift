// The MIT License (MIT)
//
// Copyright (c) 2015-2016 Qvik (www.qvik.fi)
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

/**
 UIButton that provides several utility features.
*/
open class QvikButton: UIButton {
    /// The callback for button being pressed
    open var pressedCallback: ((Void) -> Void)?
    
    /// State color map (UIControlState raw value -> color map)
    fileprivate var colorMap = [UInt: UIColor]()
    
    open class func button(frame: CGRect, type: UIButtonType = .system, pressedCallback: ((Void) -> Void)? = nil) -> QvikButton {
        let button = QvikButton(type: type)
        button.frame = frame
        button.pressedCallback = pressedCallback
        button.addTarget(button, action: #selector(QvikButton.pressed(_:)), for: .touchUpInside)
        
        return button
    }

    func pressed(_ sender: UIButton) {
        self.pressedCallback?()
    }
    
    /**
    Sets a background color for a control state.
    
    - parameter color: new background color for the control state
    - parameter state: control state to set the color for
    */
    open func setBackgroundColor(_ color: UIColor, forControlState: UIControlState) {
        colorMap[forControlState.rawValue] = color
        
        if state == forControlState {
            // This is the current control state; set the color immediately
            backgroundColor = color
        }
    }
    
    // Sets the background color for the current control state, if one is defined
    fileprivate func updateBackGroundColor() {
        if let color = colorMap[state.rawValue] {
            backgroundColor = color
        } else if let color = colorMap[UIControlState().rawValue] {
            // Default to .Normal if color for current state is not set
            backgroundColor = color
        }
    }
    
    // Hooks into enabled to change background color accordingly
    override open var isEnabled: Bool {
        didSet {
            updateBackGroundColor()
        }
    }
    
    // Hooks into highlighted to change background color accordingly
    override open var isHighlighted: Bool {
        didSet {
            updateBackGroundColor()
        }
    }
    
    // Hooks into selected to change background color accordingly
    override open var isSelected: Bool {
        didSet {
            updateBackGroundColor()
        }
    }
}
