//
//  Author.swift
//  Telfor
//
//  Created by Marko Mladenovic on 25/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

public struct Author: Codable {
    let id: String
    let name: String
    let organization: String
    let position: String
    let imagePath: String?
    let biography: String?
    var papers: [LightPaper]?
}
