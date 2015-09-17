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

//TODO move this to QvikSwift

/**
UIButton that provides a click handler using a callback block.
*/
public class BlockButton: UIButton {
    private var pressedCallback: ((Void) -> (Void))?
    
    public class func button(frame frame: CGRect, pressedCallback: ((Void) -> (Void))) -> BlockButton {
        let button = BlockButton(type: .System)
        button.frame = frame
        button.pressedCallback = pressedCallback
        button.addTarget(button, action: "pressed:", forControlEvents: .TouchUpInside)
        
        return button
    }

    func pressed(sender: UIButton) {
        self.pressedCallback?()
    }
}
