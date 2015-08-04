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

import Foundation
import UIKit
import Accelerate

/// Extensions to the UIImage class
extension UIImage {
    /** Provides a shorthand for image width. */
    public var width: Double {
        return Double(self.size.width)
    }
    
    /** Provides a shorthand for image height. */
    public var height: Double {
        return Double(self.size.height)
    }
    
    /**
    Returns an scaled-down (to the max size) image of the original image, or the
    original image if max size was not exceeded. Aspect ratio is preserved.
    
    :param: maxSize maximum size for the new image
    :returns: scaled-down image
    */
    public func scaleDown(#maxSize: CGSize) -> UIImage {
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
        let contextImage: UIImage = UIImage(CGImage: self.CGImage)!
        
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
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)
        let image: UIImage = UIImage(CGImage: imageRef, scale: self.scale, orientation: self.imageOrientation)!
        
        return image
    }

    /// Blur algorithms
    public enum BlurAlgorithm {
        case BoxConvolve
        case TentConvolve
    }

    /**
    Returns a blurred version of the image.
    
    :param: radius radius of the blur kernel, in pixels.
    :param: algorithm blur algorithm to use. .TentConvolve is faster than .BoxConvolve.
    :returns: the blurred image.
    */
    public func blur(#radius: Double, algorithm: BlurAlgorithm = .TentConvolve) -> UIImage {
        let imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        func createEffectBuffer(context: CGContext) -> vImage_Buffer {
            let data = CGBitmapContextGetData(context)
            let width = vImagePixelCount(CGBitmapContextGetWidth(context))
            let height = vImagePixelCount(CGBitmapContextGetHeight(context))
            let rowBytes = CGBitmapContextGetBytesPerRow(context)
            
            return vImage_Buffer(data: data, height: height, width: width, rowBytes: rowBytes)
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.mainScreen().scale)
        let effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage); // this takes time
        var effectInBuffer = createEffectBuffer(effectInContext)
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen().scale)
        let effectOutContext = UIGraphicsGetCurrentContext()
        var effectOutBuffer = createEffectBuffer(effectOutContext)
        
        let inputRadius = CGFloat(radius) * UIScreen.mainScreen().scale
        var radius = UInt32(floor(inputRadius * 3.0 * CGFloat(sqrt(2 * M_PI)) / 4 + 0.5))
        if radius % 2 != 1 {
            radius += 1 // force radius to be odd
        }
        
        let imageEdgeExtendFlags = vImage_Flags(kvImageEdgeExtend)
        
        if algorithm == .BoxConvolve {
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, nil, imageEdgeExtendFlags)
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, nil, 0, 0, radius, radius, nil, imageEdgeExtendFlags)
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, nil, imageEdgeExtendFlags)
        } else {
            vImageTentConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, nil, imageEdgeExtendFlags)
        }
        
        let effectImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIGraphicsEndImageContext()
        
        return effectImage
    }
}
