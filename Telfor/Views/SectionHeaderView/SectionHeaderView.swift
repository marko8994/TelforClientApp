//
//  SectionHeaderView.swift
//  Telfor
//
//  Created by Marko Mladenovic on 26/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

public protocol SectionHeaderActionDelegate: class {
    func header(_ header: SectionHeaderView, selectedWith userData: Any?)
}

//public extension SectionHeaderActionDelegate {
//    func header(_ header: SectionHeaderView, selectedWith userData: Any?) {}
//}

public class SectionHeaderView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    public var userData: Any?
    public weak var actionDelegate: SectionHeaderActionDelegate?

    public override func awakeFromNib() {
        super.awakeFromNib()
        self.rounded(with: 20.0)
        button.setTitle(LocalizedStrings.Common.viewAll, for: .normal)
    }

    @objc private func buttonTapped() {
        self.actionDelegate?.header(self, selectedWith: userData)
    }

    public func configure(userData: Any? = nil,
                          title: String? = nil,
                          influencerTitle: String? = nil,
                          hideButton: Bool = false,
                          backgroundColor: UIColor? = nil,
                          actionDelegate: SectionHeaderActionDelegate? = nil) {
        if let title = title {
            titleLabel.text = title
            button.isHidden = hideButton
            if !hideButton {
                self.actionDelegate = actionDelegate
                self.userData = userData
                self.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            }
        }
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor.withAlphaComponent(0.7)
        }
    }
}
