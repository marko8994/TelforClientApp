//
//  Date+Formater.swift
//  Telfor
//
//  Created by Marko Mladenovic on 29/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation

extension Date {
    
    func shortDate() -> String {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.dateFormat = "d MMM y"
        return formater.string(from: self)
    }
    
    func dateAndTime() -> String {
        let formater = DateFormatter()
        formater.dateStyle = .short
        formater.timeStyle = .medium
        formater.dateFormat = "HH:mm E, d MMM y"
        return formater.string(from: self)
    }
    
}
