//
//  Session.swift
//  Telfor
//
//  Created by Marko Mladenovic on 07/10/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

public struct Session: Codable {
    let id: String
    let name: String
    let date: Date
    let room: LightRoom
    let chairpersons: [LightAuthor]?
    let papers: [LightPaper]?

}
