//
//  ColorLayout.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 11/06/2021.
//

import UIKit

protocol Colorable {
    static var lightRed: UIColor { get }
    static var lightBlue: UIColor { get }
    static var backgroundColor: UIColor { get }
}

public enum ColorLayout: Colorable {
    static var lightRed: UIColor = #colorLiteral(red: 0.9389994144, green: 0.3279628158, blue: 0.3125981092, alpha: 1)
    static var lightBlue: UIColor = #colorLiteral(red: 0.3161894083, green: 0.5632007718, blue: 0.9575365186, alpha: 1)
    static var backgroundColor: UIColor = #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.968627451, alpha: 1)
}

