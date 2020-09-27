//
//  Author.swift
//  Telfor
//
//  Created by Marko Mladenovic on 25/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

struct Author: Codable {
    let uid: String
    let name: String
    let organizationName: String
    let position: String
    let imagePath: String?
    let biography: String?
    let papers: [LightPaper]?
}
