//
//  Constants.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 10/06/2021.
//

import Foundation

enum Api {
    case pokemonList
    
    var path: String {
        switch self {
        case .pokemonList:
            return "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20"
        }
    }
}
