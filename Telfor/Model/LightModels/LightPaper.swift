//
//  LightPaper.swift
//  Telfor
//
//  Created by Marko Mladenovic on 26/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

public struct LightPaper: Codable {
    let uid: String
    let title: String
    let authorNames: [String]
}
