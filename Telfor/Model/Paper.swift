//
//  Paper.swift
//  Telfor
//
//  Created by Marko Mladenovic on 25/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

enum PaperType: Int {
    case students = 0
    case regular
}

public struct Paper: Codable {
    let uid: String
    let title: String
    let summary: String
//    let type: PaperType
    let authors: [Author]
    let presentationDate: Date
    let questionsFormPath: String?
}
