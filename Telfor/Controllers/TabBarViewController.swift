//
//  TabBarViewController.swift
//  Telfor
//
//  Created by Marko Mladenovic on 29/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

public enum TabBarItem: Int {
    case primary = 0
    case secondary
    case tertiary
}

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = Theme.primaryColor
        tabBar.barTintColor = Theme.barTintColor
        tabBar.unselectedItemTintColor = Theme.unselectedItemTintColor
    }

}
