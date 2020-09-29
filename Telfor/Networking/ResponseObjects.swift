//
//  ResponseObjects.swift
//  Telfor
//
//  Created by Marko Mladenovic on 29/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

public struct AuthorResponse: Codable {
    let author: Author
    let papers: [LightPaper]
}

public struct PaperResponse: Codable {
    let paper: Paper
    let authors: [LightAuthor]
}

public struct RoomResponse: Codable {
    let room: Room
    let papers: [LightPaper]
}
