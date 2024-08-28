//
//  PokemonBasic.swift
//  Pokedex
//
//  Created by Jamerson Macedo on 28/08/24.
//

import Foundation
struct PokemonBasic : Identifiable, Decodable{
    let id : Int
    let name : String
    var spriteUrl : String {
        return "https://img.pokemondb.net/sprites/home/normal/\(name.lowercased()).png"
    }
    enum CodingKeys: String, CodingKey{
        case id = "number"
        case name
        
    }
}
