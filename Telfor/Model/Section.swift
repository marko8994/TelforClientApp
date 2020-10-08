//
//  Section.swift
//  Telfor
//
//  Created by Marko Mladenovic on 07/10/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

public struct Section: Codable {
    let id: String
    let name: String
    var sessions: [LightSession]
}
