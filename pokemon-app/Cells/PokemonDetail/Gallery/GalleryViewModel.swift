//
//  GalleryViewModel.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 13/06/2021.
//

import UIKit

struct GalleryModel {
    let titleName: String
    let imageModelList: [ImageModel]
}

class GalleryViewModel: BaseViewModel<GalleryCell, GalleryModel> {
    override public func configure() {
        super.configure()
        guard let view = view, let model = model else { return }
        
        view.titleLabel.configure(with: .init(text: model.titleName, font: .systemFont(ofSize: 22, weight: .bold), textColor: ColorLayout.baseTextColor, textAlignment: .left, backgroundColor: ColorLayout.darkYellow))
        
        view.elements = model.imageModelList.map {
            ImageViewModel(model: $0)
        }
    }
}
