//
//  Room.swift
//  Telfor
//
//  Created by Marko Mladenovic on 25/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

struct Room: Codable {
    let name: String
    let mapPath: String
    let papers: [Paper]?
}
