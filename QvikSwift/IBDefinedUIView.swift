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

import Foundation

/**
 A UIView subclass that when further subclassed, loads the contents of a xib file
 with the same name as the class.
 
 To use this, create a class that subclasses this one, and a xib file containing
 a single top level UIView object and the corresponding class set as the File's
 Owner (NOT as the custom class for the UIView). You may then connect objects in
 the xib to class's @IBOutlets and use the class in other xib files by setting it
 as a custom class of a UIView object.
 */
public class IBDefinedUIView: UIView {
    
    private var view : UIView!
    
    private func loadViewFromNib(name: String) {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: name, bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        
        addSubview(view)
    }
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib(String(self.dynamicType))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib(String(self.dynamicType))
    }
    
}