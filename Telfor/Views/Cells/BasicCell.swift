//
//  BasicCell.swift
//  Telfor
//
//  Created by Marko Mladenovic on 26/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation
import UIKit

public typealias UserData = Any

// MARK: BasicCell
public protocol BasicCell {
    func configure(with dataSource: BasicCellDataSource)
}

// MARK: BasicCellActionDelegate
public protocol BasicCellActionDelegate: class {
    func cell(_ cell: BasicCell,
              itemActionPerformedWithUserData userData: UserData?)
}

public extension BasicCellActionDelegate {
    func cell(_ cell: BasicCell,
              itemActionPerformedWithUserData userData: UserData?) {}
}

// MARK: BasicCellDataSource
public protocol BasicCellDataSource {
    var imagePath: String? { get }
    var title: String? { get }
    var subtitle: String? { get }
    var userData: UserData? { get }
    var actionDelegate: BasicCellActionDelegate? { get }
}

// MARK: Optional data source info
public extension BasicCellDataSource {
    var imagePath: String? { return nil }
    var title: String? { return nil }
    var subtitle: String? { return nil }
    var userData: UserData? { return nil }
    var actionDelegate: BasicCellActionDelegate? { return nil }
}
