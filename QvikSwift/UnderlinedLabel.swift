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

/**
Label which automatically turns all its text into underlined text.
*/
@IBDesignable
open class UnderlinedLabel: UILabel {    
    @IBInspectable
    override open var text: String? {
        get {
            return attributedText?.string
        }
        set {
            setUnderlinedText(newValue)
        }
    }
    
    fileprivate func setUnderlinedText(_ text: String?) {
        if let text = text {
            let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
            let underlineAttributedString = NSAttributedString(string: text, attributes: underlineAttribute)
            attributedText = underlineAttributedString
        } else {
            attributedText = nil
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        setUnderlinedText(text)
    }
}
