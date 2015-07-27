//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

extension String {
    public var length: Int {
        return count(self)
    }
    
    func split(separator: String) -> [String] {
        return componentsSeparatedByString(separator)
    }
}

let foo = "abc 123 kek, bar"
let s = foo.split(" ")


extension UIColor {
    convenience init(redInt: Int, greenInt: Int, blueInt: Int, alpha: Double) {
        self.init(red: CGFloat(redInt)/255.0, green: CGFloat(greenInt)/255.0, blue: CGFloat(blueInt)/255.0, alpha: CGFloat(alpha))
    }
    
    convenience init(hexString: String) {
        if !hexString.hasPrefix("#") || ((hexString.length != 7) && (hexString.length != 9)) {
            // Color string is invalid format; return white
            self.init(white: 1.0, alpha: 1.0)
        } else {
            var hex = hexString
            
            // If the format is #RRGGBB instead of #RRGGBBAA, use FF as alpha component
            if hex.length == 7 {
                hex = "\(hexString)FF"
            }
            
            let scanner = NSScanner(string: hex)
            scanner.scanLocation = 1 // Bypass '#' character
            var rgbaValue: UInt32 = 0
            if scanner.scanHexInt(&rgbaValue) {
                let red = (rgbaValue & 0xFF000000) >> 24
                let green = (rgbaValue & 0x00FF0000) >> 16
                let blue = (rgbaValue & 0x0000FF00) >> 8
                let alpha = rgbaValue & 0x000000FF
                
                println("\(red) \(green) \(blue) \(alpha)")
                
                self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0,
                    blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
            } else {
                // Parsing the hex string failed; return white
                self.init(white: 1.0, alpha: 1.0)
            }
        }
    }
}

let c1 = UIColor(hexString: "badstring")
let c2 = UIColor(hexString: "#rrggbb")
let c3 = UIColor(hexString: "#112233")
let c4 = UIColor(hexString: "#010203AA")

let x = [1, 2]

let imageData = NSData(contentsOfURL: NSURL(string: "http://miriadna.com/desctopwalls/images/max/Ideal-landscape.jpg")!)
let image = UIImage(data: imageData!)

let croppedImage = image!.cropImageToSquare()
let scaledImage = image!.scaleDown(maxSize: CGSize(width: 350, height: 350))
