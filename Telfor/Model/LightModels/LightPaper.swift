//
//  LightPaper.swift
//  Telfor
//
//  Created by Marko Mladenovic on 26/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

public struct LightPaper: Codable {
    let id: String
    let title: String
    let authorNames: [String]
}

//enum CodingKeys : String, CodingKey {
//    case authorNames
//}
//
//public init(from decoder: Decoder) throws {
//    let values = try decoder.container(keyedBy: CodingKeys.self)
//    authorNames = try values.decode([String]?.self, forKey: .authorNames)
//}
