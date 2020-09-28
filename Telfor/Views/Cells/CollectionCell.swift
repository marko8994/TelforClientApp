//
//  CollectionCell.swift
//  Telfor
//
//  Created by Marko Mladenovic on 26/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCell: UICollectionViewCell, BasicCell {
    
    @IBOutlet weak var subviewsContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    public var userData: UserData?

    public func configure(with info: BasicCellDataSource) {
        configureImageView(with: info)
        configureTitleLabel(with: info)
        userData = info.userData
        setNeedsLayout()
        layoutIfNeeded()
    }


    private func configureImageView(with info: BasicCellDataSource) {
        guard let imageView = imageView else { return }
        if let imagePath = info.imagePath, let imageUrl = URL(string: imagePath) {
            imageView.kf.setImage(with: imageUrl, placeholder: Assets.avatarPlaceholder.image)
        } else {
            imageView.image = Assets.avatarPlaceholder.image
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
