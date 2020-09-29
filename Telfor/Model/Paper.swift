//
//  Paper.swift
//  Telfor
//
//  Created by Marko Mladenovic on 25/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

enum PaperType: String, Codable {
    case students
    case regular
    case special
    
    var name: String {
        switch self {
        case .students:
            return LocalizedStrings.Common.studentsPaper
        case .regular:
            return LocalizedStrings.Common.regularPaper
        case .special:
            return LocalizedStrings.Common.specialPaper
        }
    }
}

public struct Paper: Codable {
    let id: String
    let title: String
    let summary: String
    let type: PaperType
    let presentationDate: Date
    let questionsFormPath: String?
    let room: LightRoom
    var authors: [LightAuthor]?
}
