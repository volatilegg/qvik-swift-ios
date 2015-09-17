//
//  UIImageExtensions.swift
//  QvikSwift
//
//  Created by Matti Dahlbom on 12.7.201528.
//  Copyright (c) 2015 Qvik. All rights reserved.
//

import Foundation
import UIKit

/// Extensions to the UIImage class
extension UIImage {
    /**
    Returns an scaled-down (to the max size) image of the original image, or the
    original image if max size was not exceeded. Aspect ratio is preserved.
    
    :param: maxSize maximum size for the new image
    :returns: scaled-down image
    */
    public func scaleDown(maxSize maxSize: CGSize) -> UIImage {
        let myWidth = self.size.width
        let myHeight = self.size.height
        
        if maxSize.height >= myHeight && maxSize.width >= myWidth {
            return self
        }
        
        // Decide how much to scale down by looking at the differences in width/height
        // against the max size
        let xratio = maxSize.width / myWidth
        let yratio = maxSize.height / myHeight
        let ratio = min(xratio, yratio)
        
        let size = CGSizeApplyAffineTransform(self.size, CGAffineTransformMakeScale(ratio, ratio))
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    /**
    Crops the image to a square; from the middle of the original image, using the largest
    possible square area that fits in the original image.
    
    :returns: the cropped image. Note that the dimensions may be off by +-1 pixels.
    */
    public func cropImageToSquare() -> UIImage {
        let contextImage: UIImage = UIImage(CGImage: self.CGImage!)
        
        let contextSize: CGSize = contextImage.size
        
        let posX: CGFloat
        let posY: CGFloat
        let width: CGFloat
        let height: CGFloat
        
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            width = contextSize.height
            height = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            width = contextSize.width
            height = contextSize.width
        }
        
        let rect: CGRect = CGRectMake(posX, posY, width, height)
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        let image: UIImage = UIImage(CGImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
        
        return image
    }
}
