//
//  PokemonService.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 10/06/2021.
//

import Foundation

class PokemonService {
    typealias getPkCompletion = (Result<[Pokemon],Error>) -> Void
    
    static let shared = PokemonService()
    private var pokemonList: [Pokemon] = []
    
    func getPokemon(completion: @escaping getPkCompletion) {
        ApiService.shared.getCodable(ofType: PokemonPreviewList.self, from: Api.pokemonList.path) { result in
            
            switch result {
            case .success(let pokemonPreviewList):
                let group = DispatchGroup()
                pokemonPreviewList.results.forEach { pokemonPreview in
                    group.enter()
                    ApiService.shared.getCodable(ofType: Pokemon.self, from: pokemonPreview.url) { result in
                        
                        switch result {
                        case .success(let pokemon):
                            self.pokemonList.append(pokemon)
                        case .failure(let error):
                            completion(.failure(error))
                        }
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    completion(.success(self.pokemonList))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func writePokemon(pokemonList: [Pokemon]) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(pokemonList)
            FileManager.default.createFile(atPath: FileManager.pokemonUrlPath.path, contents: encodedData)
        } catch {
            print(error)
        }
    }
    
    func readPokemon() -> Result<[Pokemon],Error> {
        do {
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: FileManager.pokemonUrlPath)
            let decodedData = try decoder.decode([Pokemon].self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
    
    func writePokemonImages(from pokemonList: [Pokemon]) {
        pokemonList.forEach {
            $0.allImages.forEach { image in
                
            }
        }
    }
}
