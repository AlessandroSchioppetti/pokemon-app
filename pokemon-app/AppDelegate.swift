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
                pokemonList.forEach {
                    print($0.name)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return true
    }
}

