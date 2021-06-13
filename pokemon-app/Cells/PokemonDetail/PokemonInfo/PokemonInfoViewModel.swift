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
    }
}

