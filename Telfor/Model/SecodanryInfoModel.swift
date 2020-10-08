//
//  HomeModel.swift
//  Telfor
//
//  Created by Marko Mladenovic on 28/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

public struct SecodanryInfoModel: Codable {
    let name: String
    let imagePaths: String
    let authors: [LightAuthor]
    let papers: [LightPaper]
    let rooms: [LightRoom]
}
