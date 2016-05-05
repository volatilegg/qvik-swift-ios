//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

extension CGPoint {
    public func middlePoint(another: CGPoint) -> CGPoint {
        return CGPoint(x: (self.x + another.x) / 2, y: (self.y + another.y) / 2)
    }
}

let array1 = [1, 2, 3, 4]
let value1 = array1[1..<3]

extension CGRect {
    
    /**
    Returns a scaled version of the rect.
    
    :param xScale
    */
    public func scaled(x x: CGFloat, y: CGFloat) -> CGRect {
        let w = self.width * x
        let h = self.height * y
        let wd = w - self.width
        let hd = h - self.height
        return CGRect(x: self.origin.x - (wd / 2), y: self.origin.y - (hd / 2), width: w, height: h)
    }
    
}

let p1 = CGPoint(x: 256, y: 234)
let p2 = CGPoint(x: -231, y: 879)
let p3 = p1.middlePoint(p2)

let rect = CGRect(x: 5, y: 10, width: 20, height: 20)
let scaled = rect.scaled(x: 2, y: 2)


extension String {
    public var length: Int {
        return self.characters.count
    }
    
    func split(separator: String) -> [String] {
        return componentsSeparatedByString(separator)
    }
}

let foo = "abc 123 kek, bar"
let s = foo.split(" ")

extension NSDateFormatter {
    public class func iso8601ZFormatter() -> NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone(name: "UTC")
        
        return formatter
    }
}

let f = NSDateFormatter.iso8601ZFormatter()
let date = f.dateFromString("2008-05-11T15:30:00.000Z")
let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
let comps = calendar?.components([.Year, .Month, .Day, .Minute, .Second, .Nanosecond], fromDate: date!)
print(comps!.year)
print(comps!.day)


let components = NSDateComponents()
components.year = 1987
components.month = 3
components.day = 17
components.hour = 14
components.minute = 20
components.second = 0

let date2 = calendar?.dateFromComponents(components)

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
                
                print("\(red) \(green) \(blue) \(alpha)")
                
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
