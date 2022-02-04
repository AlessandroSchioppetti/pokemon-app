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
        getPokemon { [weak self] result in
            switch result {
            case .success(let list):
                if let error = self?.writePokemon(pokemonList: list) {
                    completion(error)
                    return
                }
                self?.getPokemonImages(from: list) { [weak self] result in
                    switch result {
                    case .success((let allPkImages, let allPkProfileImages)):
                        self?.writePkImges(allPkGalleryImageList: allPkImages,
                                                           allPkProfileImages: allPkProfileImages)
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
    
    func readPkImages(from url: URL) -> Result<[UIImage],Error> {
        var images = [UIImage]()
        do {
            let urls = try FileManager.default.contentsOfDirectory(at: url,
                                                                   includingPropertiesForKeys: nil,
                                                                   options: .skipsHiddenFiles)
            try urls.forEach {
                let data = try Data(contentsOf: $0)
                images.append(UIImage(data: data) ?? UIImage())
            }
            return .success(images)
        } catch {
            return .failure(error)
        }
    }
}

// MARK: - private
private extension PokemonService {
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
        var pkGalleryImageList: [String: [UIImage]] = [:]
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
                            if urlString == pokemon.profileImage {
                                pkImageProfileList[pokemon.name] = image
                            } else {
                                if let _ = pkGalleryImageList[pokemon.name] {
                                    pkGalleryImageList[pokemon.name]?.append(image)
                                } else {
                                    pkGalleryImageList[pokemon.name] = [image]
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
            return completion(.success((pkGalleryImageList, pkImageProfileList)))
        }
    }
    
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
    
    func writePkImges(allPkGalleryImageList: [String: [UIImage]],
                      allPkProfileImages: [String: UIImage]) {
        allPkGalleryImageList.forEach { dict in
            dict.value.forEach { image in
                writeImage(image: image, to: URL.pokemonImages.appendingPathComponent(dict.key).appendingPathComponent(Dir.galleryImages.rawValue))
            }
        }
        allPkProfileImages.forEach { dict in
            writeImage(image: dict.value, to: URL.pokemonImages.appendingPathComponent(dict.key).appendingPathComponent(Dir.profileImage.rawValue))
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
