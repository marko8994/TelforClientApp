//
//  SpotlightCell.swift
//  Telfor
//
//  Created by Marko Mladenovic on 26/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit
import Kingfisher

class SpotlightCell: UITableViewCell {

    @IBOutlet weak var headerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with imagePath: String?) {
        if let imagePath = imagePath, let imageUrl = URL(string: imagePath) {
            headerImage.kf.setImage(with: imageUrl, placeholder: Assets.spotlightPlaceholder.image) {[weak self] (result) in
                switch result {
                case .failure(let error):
                    print("\(error)")
                case .success:
                    return
                }
            }
        } else {
            headerImage.image = Assets.spotlightPlaceholder.image
        }
    }
}
