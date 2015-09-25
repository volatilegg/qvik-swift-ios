//
//  TouchDetectView.swift
//  QvikSwift
//
//  Created by Matti Dahlbom on 25/09/15.
//  Copyright © 2015 Qvik. All rights reserved.
//

import UIKit

/**
A view usable as a 'dimmer' view for dimming a background and receiving a
touch event (through a callback closure) for dismissing foreground elements.

Set ```touchedCallback``` to receive touch events.

By default this view's background is black. Set the alpha (default: 0.5) as required.

Sample usage:

```swift
dimmerView = TouchDetectView(frame: window!.frame)
dimmerView?.touchedCallback = { [weak self] in
self?.hideSomethingAndDisposeOfDimmerView()
}
window!.addSubview(dimmerView!)
```
*/
public class TouchDetectView: UIView {
    /// Called when this view was touched.
    public var touchedCallback: (Void -> Void)?
    
    func tapped() {
        touchedCallback?()
    }
    
    private func commonInit() {
        alpha = 0.5
        backgroundColor = UIColor.blackColor()
        userInteractionEnabled = true
        
        // Add tap recognizer for the image
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "tapped")
        addGestureRecognizer(tapRecognizer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
}
