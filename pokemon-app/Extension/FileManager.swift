//
//  FileManager.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 10/06/2021.
//

import Foundation

public extension FileManager {
    static var applicationSupportDirectory: URL {
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        if !fileManager.fileExists(atPath: url.path) {
            try? fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return url
    }
    
    static var pokemonUrlPath: URL {
        FileManager.applicationSupportDirectory.appendingPathComponent(FileName.pokemon.name)
    }
}
