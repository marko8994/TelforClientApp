//
//  CollectionDataSource.swift
//  Telfor
//
//  Created by Marko Mladenovic on 26/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import Foundation
import UIKit

public class CollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    private weak var containerCell: CollectionContainerCell?
    private weak var collectionView: UICollectionView!
    private var items: [BasicCellDataSource]
    public weak var actionDelegate: BasicCollectionContainerActionDelegate?

    init(containerCell: CollectionContainerCell,
         collectionView: UICollectionView,
         items: [BasicCellDataSource],
         actionDelegate: BasicCollectionContainerActionDelegate? = nil) {
        self.containerCell = containerCell
        self.collectionView = collectionView
        self.items = items
        self.actionDelegate = actionDelegate
    }

    // MARK: UICollectionViewDataSource methods

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            let reuseIdentifier = "basicCollectionCell"
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                             for: indexPath)
                as? (UICollectionViewCell & BasicCell) {
                let item = items[indexPath.row]
                cell.configure(with: item)
                return cell
            }
            fatalError("No cell with reuse identifier: \(reuseIdentifier) for row: \(indexPath.row)")
    }

    // MARK: UICollectionViewDelegate methods

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        if let containerCell = containerCell, let userData = item.userData {
            actionDelegate?.cell(containerCell, collectionItemSelectedWithUserData: userData)
        }
    }

}
