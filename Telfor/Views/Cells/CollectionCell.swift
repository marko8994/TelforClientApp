//
//  CollectionCell.swift
//  Telfor
//
//  Created by Marko Mladenovic on 26/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell, BasicCell {
    
    @IBOutlet weak var subviewsContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    public var userData: UserData?
    public weak var actionDelegate: BasicCellActionDelegate?

    public func configure(with info: BasicCellDataSource) {
        configureImageView(with: info)
        configureTitleLabel(with: info)
        userData = info.userData
        self.actionDelegate = info.actionDelegate
        setNeedsLayout()
        layoutIfNeeded()
    }


    private func configureImageView(with info: BasicCellDataSource) {
        guard let imageView = imageView else {return}
        if let imagePath = info.imagePath, let imageUrl = URL(string: imagePath) {
            imageView.load(url: imageUrl)
        } else {
            imageView.load(url: nil)
        }
    }

    private func configureTitleLabel(with info: BasicCellDataSource) {
        guard let titleLabel = titleLabel else {return}
        titleLabel.text = info.title
    }

    private func setLayout() {
        subviewsContainer?.backgroundColor = UIColor.systemGray6
        let cornerRadius: CGFloat = 10.0
        subviewsContainer.rounded(with: cornerRadius)
        imageView.toCircle()
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }
}
