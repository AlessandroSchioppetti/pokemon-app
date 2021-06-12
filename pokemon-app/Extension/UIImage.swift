//
//  UIImage.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 12/06/2021.
//

import UIKit

extension UIImageView {
    func makeRounded(borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
