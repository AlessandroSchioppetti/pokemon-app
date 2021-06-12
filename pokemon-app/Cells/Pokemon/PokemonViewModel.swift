//
//  PokemonViewModel.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 12/06/2021.
//

import UIKit

struct PokemonModel {
    let name: String
    let imageString: String
}

class PokemonViewModel: BaseViewModel<PokemonCell, PokemonModel> {
    override public func configure() {
        super.configure()
        guard let view = view, let model = model else { return }
        
        view.imageView.layer.cornerRadius = 20.0
        view.imageView.contentMode = .scaleAspectFit
        view.imageView.image = UIImage(named: model.imageString)
        
        view.titleLabel.configure(with: LabelLayout(text: model.name,
                                                    font: UIFont.systemFont(ofSize: 22, weight: .heavy),
                                                    adjustsFontSizeToFitWidth: true))
    }
}
