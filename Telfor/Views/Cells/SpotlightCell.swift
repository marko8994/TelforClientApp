//
//  SpotlightCell.swift
//  Telfor
//
//  Created by Marko Mladenovic on 26/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

class SpotlightCell: UITableViewCell {

    @IBOutlet weak var headerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with imageUrl: String) {
        if let imageUrl = URL(string: imageUrl) {
            headerImage.load(url: imageUrl)
        }
    }
}
