//
//  ImageViewModel.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 12/06/2021.
//

import UIKit

class ImageModel {
    let image: UIImage
    let height: CGFloat?
    let width: CGFloat?
    let cornerRadius: CGFloat?
    let borderWidth: CGFloat?
    let borderColor: UIColor?
    
    public init(image: UIImage,
                height: CGFloat? = nil,
                width: CGFloat? = nil,
                cornerRadius: CGFloat? = nil,
                borderWidth: CGFloat? = nil,
                borderColor: UIColor? = nil) {
        self.image = image
        self.height = height
        self.width = width
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }
}

class ImageViewModel: BaseViewModel<ImageCell, ImageModel> {
    override public func configure() {
        super.configure()
        guard let view = view, let model = model else { return }
        view.imageView.contentMode = .scaleAspectFit
        view.imageView.image = model.image
        
        if let height = model.height { view.imageView.heightAnchor.constraint(equalToConstant: height).isActive = true }
        if let width = model.width { view.imageView.widthAnchor.constraint(equalToConstant: width).isActive = true }
        
        if let radius = model.cornerRadius, let borderWidth = model.borderWidth, let borderColor = model.borderColor {
            view.imageView.makeRounded(borderWidth: borderWidth, borderColor: borderColor, cornerRadius: radius)
        }
    }
}
