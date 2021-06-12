//
//  LabelLayout.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 12/06/2021.
//

import UIKit

class LabelLayout {
    var text: String?
    var font: UIFont
    var textColor: UIColor
    var textAlignment: NSTextAlignment
    var numberOfLines: Int
    var adjustsFontSizeToFitWidth: Bool
    
    init(text: String? = nil,
         font: UIFont = .systemFont(ofSize: 20.0, weight: .regular),
         textColor: UIColor = ColorLayout.baseTextColor,
         textAlignment: NSTextAlignment = NSTextAlignment.center,
         numberOflines: Int = 1,
         adjustsFontSizeToFitWidth: Bool = false) {
        
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOflines
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
    }
}

extension UILabel {
    func configure(with labelLayout: LabelLayout) {
        text = labelLayout.text
        font = labelLayout.font
        textColor = labelLayout.textColor
        textAlignment = labelLayout.textAlignment
        numberOfLines = labelLayout.numberOfLines
        adjustsFontSizeToFitWidth = labelLayout.adjustsFontSizeToFitWidth
    }
}
