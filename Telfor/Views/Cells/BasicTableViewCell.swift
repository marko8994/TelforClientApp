//
//  BasicTableViewCell.swift
//  Telfor
//
//  Created by Marko Mladenovic on 26/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell, BasicCell {
    
    func configure(with dataSource: BasicCellDataSource) {
        textLabel?.text = dataSource.title
        if let subtitle = dataSource.subtitle {
            detailTextLabel?.text = subtitle
        }
    }
}
