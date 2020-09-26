//
//  CellInfo.swift
//  Telfor
//
//  Created by Marko Mladenovic on 26/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

public struct BasicCellInfo: BasicCellDataSource {
    public var userData: UserData?
    public var imagePath: String?
    public var title: String?
    public var subtitle: String?

    public init(userData: UserData? = nil,
                imagePath: String? = nil,
                title: String? = nil,
                subtitle: String? = nil) {
        self.userData = userData
        self.imagePath = imagePath
        self.title = title
        self.subtitle = subtitle
    }
}
