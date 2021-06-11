//
//  PokemonService.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 10/06/2021.
//

import UIKit

class PokemonService {
    typealias getPkCompletion = (Result<[Pokemon],Error>) -> Void
    
    static let shared = PokemonService()
    private var pokemonList: [Pokemon] = []
    
    // MARK: - network operation
    func getPokemon(completion: @escaping getPkCompletion) {
        ApiService.shared.getCodable(ofType: PokemonPreviewList.self, from: Api.pokemonList.path) { result in
            
            switch result {
            case .success(let pokemonPreviewList):
                let group = DispatchGroup()
                let serialQueue = DispatchQueue(label: "serialQueue")
                pokemonPreviewList.results.forEach { pokemonPreview in
                    group.enter()
                    ApiService.shared.getCodable(ofType: Pokemon.self, from: pokemonPreview.url) { result in
                        
                        switch result {
                        case .success(let pokemon):
                            serialQueue.async {
                                self.pokemonList.append(pokemon)
                                group.leave()
                            }
                        case .failure(let error):
                            completion(.failure(error))
                            group.leave()
                        }
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
    
    func getPokemonImages(from pokemonList: [Pokemon]) {
        var pkImageList: [String: [UIImage]] = [:]
        
        let imageGroup = DispatchGroup()
        let imageQueue = DispatchQueue(label: "imageQueue")
        
        pokemonList.forEach { pokemon in
            pokemon.allImages.forEach {
                imageGroup.enter()
                ApiService.shared.getImage(from: $0) { result in
                    switch result {
                    case .success(let image):
                        imageQueue.async {
                            if let _ = pkImageList[pokemon.name] {
                                pkImageList[pokemon.name]?.append(image)
                            } else {
                                pkImageList[pokemon.name] = [image]
                            }
                            imageGroup.leave()
                        }
                    case .failure(let error):
                        print(error)
                        imageGroup.leave()
                    }
                }
            }
        }
        imageGroup.notify(queue: .main) {
            pkImageList.forEach { dict in
                print(dict.key)
                for img in dict.value {
                    print(img)
                }
                print("\n")
            }
        }
    }
    
    // MARK: - local operation
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
}
