//
//  TableTextViewCell.swift
//  Telfor
//
//  Created by Marko Mladenovic on 27/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

class TableTextViewCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public var content: String? {
        didSet {
            textView.text = content
        }
    }
}
