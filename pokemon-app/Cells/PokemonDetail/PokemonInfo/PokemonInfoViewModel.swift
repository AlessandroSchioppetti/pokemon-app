//
//  PokemonInfoViewModel.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 13/06/2021.
//

import UIKit

struct PokemonInfoModel {
    let title: String
    let info: [String]
}

class PokemonInfoViewModel: BaseViewModel<PokemonInfoCell, PokemonInfoModel> {
    override public func configure() {
        super.configure()
        guard let view = view, let model = model else { return }
        
        view.titleLabel.configure(with: .init(text: model.title, font: .systemFont(ofSize: 22, weight: .bold), textColor: ColorLayout.baseTextColor, textAlignment: .left, backgroundColor: ColorLayout.darkYellow))
        
        model.info.forEach {
            let infoLabel = UILabel()
            infoLabel.configure(with: .init(text: $0, font: .systemFont(ofSize: 20, weight: .medium), textColor: ColorLayout.baseTextColor, textAlignment: .center))
            infoLabel.translatesAutoresizingMaskIntoConstraints = false
            infoLabel.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
            view.infoStackView.addArrangedSubview(infoLabel)
        }
    }
}

