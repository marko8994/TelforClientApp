//
//  CollectionContainerCell.swift
//  Telfor
//
//  Created by Marko Mladenovic on 26/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

public protocol BasicCollectionContainerActionDelegate: class {
    func cell(_ cell: CollectionContainerCell,
              collectionItemSelectedWithUserData userData: UserData?)
}
public extension BasicCollectionContainerActionDelegate {
    func cell(_ cell: CollectionContainerCell,
              collectionItemSelectedWithUserData userData: UserData?) {}
}

public class CollectionContainerCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var constraintCollectionViewHeight: NSLayoutConstraint!

    public var collectionDataSource: CollectionDataSource!
    public var collectionViewHeight: CGFloat? {
        didSet {
            if let collectionViewHeight = collectionViewHeight,
                let constraintCollectionViewHeight = constraintCollectionViewHeight,
                constraintCollectionViewHeight.constant != collectionViewHeight {
                constraintCollectionViewHeight.constant = collectionViewHeight
                setNeedsLayout()
            }
        }
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        if let collectionViewHeight = collectionViewHeight {
            constraintCollectionViewHeight.constant = collectionViewHeight
        }
    }

    public func configure(items: [BasicCellDataSource],
                          actionDelegate: BasicCollectionContainerActionDelegate? = nil) {
        collectionDataSource = CollectionDataSource(containerCell: self,
                                                    collectionView: collectionView,
                                                    items: items,
                                                    actionDelegate: actionDelegate)
        self.collectionView.delegate = collectionDataSource
        self.collectionView.dataSource = collectionDataSource
        self.collectionView.reloadData()
    }
}
