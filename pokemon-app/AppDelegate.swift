//
//  AppDelegate.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 09/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        PokemonService.shared.getPokemon { result in
            switch result {
            case .success(let pokemonList):
                PokemonService.shared.writePokemon(pokemonList: pokemonList)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return true
    }
}

