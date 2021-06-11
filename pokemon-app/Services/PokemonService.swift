//
//  PokemonService.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 10/06/2021.
//

import UIKit

class PokemonService {
    typealias getPkCompletion = (Result<[Pokemon],Error>) -> Void
    typealias getPkImagesCompletion = ((Result<([String: [UIImage]],[String: UIImage]),Error>) -> Void)
    
    static let shared = PokemonService()
    private var pokemonList: [Pokemon] = []
    
    func getAndSavePokemon(completion: @escaping (Error?) -> Void) {
        PokemonService.shared.getPokemon { result in
            switch result {
            case .success(let list):
                if let error = PokemonService.shared.writePokemon(pokemonList: list) {
                    completion(error)
                    return
                }
                PokemonService.shared.getPokemonImages(from: list) { result in
                    switch result {
                    case .success((let allPkImages, let allPkProfileImages)):
                        PokemonService.shared.writePkImges(allPkImages: allPkImages,
                                                           allPkProfileImages: allPkProfileImages)
                        self.pokemonList = list
                        completion(nil)
                    case .failure(let error):
                        completion(error)
                        return
                    }
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func getPokemonList() -> [Pokemon] {
        pokemonList
    }
}

// MARK: - private
private extension PokemonService {
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
    
    func getPokemonImages(from pokemonList: [Pokemon], completion: @escaping getPkImagesCompletion) {
        var pkImageList: [String: [UIImage]] = [:]
        var pkImageProfileList: [String: UIImage] = [:]
        
        let imageGroup = DispatchGroup()
        let imageQueue = DispatchQueue(label: "imageQueue")
        
        pokemonList.forEach { pokemon in
            pokemon.allImages.forEach { urlString in
                imageGroup.enter()
                ApiService.shared.getImage(from: urlString) { result in
                    switch result {
                    case .success(let image):
                        imageQueue.async {
                            if urlString == pokemon.images.other.prettyImage.front_default {
                                pkImageProfileList[pokemon.name] = image
                            } else {
                                if let _ = pkImageList[pokemon.name] {
                                    pkImageList[pokemon.name]?.append(image)
                                } else {
                                    pkImageList[pokemon.name] = [image]
                                }
                            }
                            imageGroup.leave()
                        }
                    case .failure(let error):
                        completion(.failure(error))
                        imageGroup.leave()
                    }
                }
            }
        }
        imageGroup.notify(queue: .main) {
            return completion(.success((pkImageList, pkImageProfileList)))
        }
    }
    
    // MARK: - local operation
    func writePokemon(pokemonList: [Pokemon]) -> Error? {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(pokemonList)
            FileManager.default.createFile(atPath: URL.pokemonUrlPath.path, contents: encodedData)
            return nil
        } catch {
            return error
        }
    }
    
    func readPokemon() -> Result<[Pokemon],Error> {
        do {
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: URL.pokemonUrlPath)
            let decodedData = try decoder.decode([Pokemon].self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
    
    func writePkImges(allPkImages: [String: [UIImage]], allPkProfileImages: [String: UIImage]) {
        allPkImages.forEach { dict in
            dict.value.forEach { image in
                writeImage(image: image, to: URL.pokemonImages.appendingPathComponent(dict.key).appendingPathComponent("frontBackImages"))
            }
        }
        allPkProfileImages.forEach { dict in
            writeImage(image: dict.value, to: URL.pokemonImages.appendingPathComponent(dict.key).appendingPathComponent("profileImages"))
        }
    }
    
    func writeImage(image: UIImage, to urlPath: URL) {
        if let data = image.pngData() {
            do {
                if !FileManager.default.fileExists(atPath: urlPath.path) {
                    try FileManager.default.createDirectory(atPath: urlPath.path, withIntermediateDirectories: true, attributes: nil)
                }
                try data.write(to: urlPath.appendingPathComponent(UUID().uuidString))
            } catch {
                print(error)
            }
        }
    }
}
