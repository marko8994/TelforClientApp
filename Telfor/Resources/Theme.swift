//
//  Theme.swift
//  Telfor
//
//  Created by Marko Mladenovic on 29/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation
import UIKit

public class Theme {
        
    class var primaryColor: UIColor {
        return UIColor(hexString: "#78AE3C")
    }
    
    class var secondaryColor: UIColor {
        return UIColor(hexString: "#FFE800")
    }
    
    class var tertiaryColor: UIColor {
        return UIColor(hexString: "#2AAEE0")
    }
    
    class var quetarnaryColor: UIColor {
        return UIColor(hexString: "#D02329")
    }
    
    class var barTintColor: UIColor {
        return UIColor.systemGray6
    }
    
    class var unselectedItemTintColor: UIColor {
        return UIColor.lightGray
    }
    
    class var cellBackgroundColor: UIColor {
        return UIColor.systemGray6
    }

}

extension Theme {
    class func setAppearance() {
        setNavigationBarAppearance()
    }
    
    private static func setNavigationBarAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black,
                                                            .font: UIFont.systemFont(ofSize: 24, weight: .bold)]
        UINavigationBar.appearance().barTintColor = self.primaryColor
        UINavigationBar.appearance().tintColor = .black
    }
}

extension UIColor {
    convenience public init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let redComponent = Int(color >> 16) & mask
        let greenComponent = Int(color >> 8) & mask
        let blueComponent = Int(color) & mask

        let red   = CGFloat(redComponent) / 255.0
        let green = CGFloat(greenComponent) / 255.0
        let blue  = CGFloat(blueComponent) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
