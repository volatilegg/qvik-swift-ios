//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let x = [1, 2]

let imageData = NSData(contentsOfURL: NSURL(string: "http://miriadna.com/desctopwalls/images/max/Ideal-landscape.jpg")!)
let image = UIImage(data: imageData!)

let croppedImage = image!.cropImageToSquare()
let scaledImage = image!.scaleDown(maxSize: CGSize(width: 350, height: 350))
