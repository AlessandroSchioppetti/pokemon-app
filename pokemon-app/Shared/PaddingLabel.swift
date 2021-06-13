//
//  PaddingLabel.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 13/06/2021.
//

import UIKit

class PaddingLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
}
