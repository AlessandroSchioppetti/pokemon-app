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
            case .success(let list):
                for (index, p) in list.enumerated() {
                    print(index, p.name)
                }
                PokemonService.shared.getPokemonImages(from: list) { result in
                    switch result {
                    case .success((let pkImgList, let pkImgProfileList)):
                        print(pkImgList)
                        print("\n")
                        print(pkImgProfileList)
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        return true
    }
}

