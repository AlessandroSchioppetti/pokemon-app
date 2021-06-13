//
//  Constants.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 10/06/2021.
//

import Foundation

public enum Api {
    case pokemonList
    
    var path: String {
        switch self {
        case .pokemonList:
            return "https://pokeapi.co/api/v2/pokemon?offset=20&limit=10"
        }
    }
}

public enum Dir: String {
    case galleryImages = "GalleryImages"
    case profileImage = "ProfileImages"
}
