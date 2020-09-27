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
//        textView.contentInset = UIEdgeInsets.zero
//        textView.textContainerInset = UIEdgeInsets.zero
//        textView.textContainer.lineFragmentPadding = 0
//        textView.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    public var content: String? {
        didSet {
            textView.text = content
        }
    }
    
//    public var textContent: String? {
//        didSet {
//            let attributedText = textContent?.formattedDesriptionText()
//            textView.attributedText = attributedText
//        }
//    }
//    public var textContent: String? {
//        didSet {
//            let attributedText = textContent?.formattedDesriptionText()
//            textView.attributedText = attributedText
//        }
//    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        textView.contentInset = UIEdgeInsets.zero
//        textView.textContainerInset = UIEdgeInsets.zero
//        textView.textContainer.lineFragmentPadding = 0
//        textView.textContainer.lineBreakMode = .byTruncatingTail
//        textView.textColor = OIPManager.shared.theme.primaryText
//    }

}

//public extension String {
//    func formattedDesriptionText(font: UIFont? = UIFont.systemFont(ofSize: 17.0)) -> NSMutableAttributedString {
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1.3
//        let attrString = NSMutableAttributedString(string: self)
//        let attrRange = NSRange.init(location: 0, length: attrString.length)
//        attrString.addAttribute(NSAttributedString.Key.paragraphStyle,
//                                value: paragraphStyle, range: attrRange)
//        if let font = font {
//            attrString.addAttribute(NSAttributedString.Key.font, value: font, range: attrRange)
//        }
//        return attrString
//    }
//}
