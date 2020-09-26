//
//  DeviceInfo.swift
//  Telfor
//
//  Created by Marko Mladenovic on 26/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation
import UIKit

public class DeviceInfo {
    public static var isCompactScreen: Bool = {
        return UIScreen.main.bounds.width <= 320
    }()

    public static var bottomInset: CGFloat = {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }()

    public static var statusBarHeight: CGFloat = {
        return UIApplication.shared.statusBarFrame.size.height
    }()
}

extension UIImageView {
    public func load(url: URL?) {
        if let url = url {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
        } else {
            self.image = UIImage(named: "avatarPlaceholder")
        }
        
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
    }
}

extension UIView {
    public func rounded(with radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

    public func toCircle() {
        rounded(with: bounds.size.height / 2.0)
    }
}
