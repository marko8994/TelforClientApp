//
//  InfoModel.swift
//  Telfor
//
//  Created by Marko Mladenovic on 29/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

public struct TertiaryInfoModel: Codable {
    let name: String
    let description: String
    let imagePaths: String
    let startDate: Date
    let endDate: Date
    let mapPath: String?
    let surveyPath: String?
}
