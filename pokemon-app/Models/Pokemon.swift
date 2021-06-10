//
//  Pokemon.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 09/06/2021.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let stats: [Stat]
    let types: [TypeElement]
    let images: Images

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case stats
        case types
        case images = "sprites"
    }
    
    public var allImages: [String] {
        return [images.front_default, images.front_shiny, images.back_default, images.back_shiny, images.other.prettyImage.front_default]
    }
}

// MARK: - Stat
struct Stat: Codable {
    let value: Int
    let statDetail: StatDetail
    
    enum CodingKeys: String, CodingKey {
        case value = "base_stat"
        case statDetail = "stat"
    }
}

// MARK: - StatDetail
struct StatDetail: Codable {
    let name: String
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let type: Type
}

// MARK: - Type
struct Type: Codable {
    let name: String
}

// MARK: - Image
struct Images: Codable {
    let back_default: String
    let back_shiny: String
    let front_default: String
    let front_shiny: String
    let other: OtherImage
}

// MARK: - OtherImage
struct OtherImage: Codable {
    let prettyImage: PrettyImage
    
    enum CodingKeys: String, CodingKey {
        case prettyImage = "official-artwork"
    }
}

// MARK: - PrettyImage
struct PrettyImage: Codable {
    let front_default: String
}
