//
//  UIView.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 11/06/2021.
//

import UIKit

extension UIView {
    func add(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}
