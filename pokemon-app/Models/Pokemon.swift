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
}

// MARK: - computedProperties
extension Pokemon {
    public var allImages: [String] {
        return [images.front_default,
                images.front_shiny,
                images.back_default,
                images.back_shiny,
                images.other.prettyImage.front_default]
    }
    
    public var typeList: [String] {
        return types.map { $0.type.name }
    }
    
    public var profileImage: String {
        images.other.prettyImage.front_default
    }
    
    public var statsList: [String] {
        var stats = [String]()
        self.stats.forEach {
            stats.append("\($0.statDetail.name): \($0.value)")
        }
        return stats
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
