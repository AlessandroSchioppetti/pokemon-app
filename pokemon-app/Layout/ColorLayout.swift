//
//  ColorLayout.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 11/06/2021.
//

import UIKit

protocol Colorable {
    static var lightRed: UIColor { get }
}

public enum ColorLayout: Colorable {
    static var lightRed: UIColor = #colorLiteral(red: 0.9389994144, green: 0.3279628158, blue: 0.3125981092, alpha: 1)
}

