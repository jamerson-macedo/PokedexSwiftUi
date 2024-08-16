//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Jamerson Macedo on 16/08/24.
//

import Foundation

import Foundation

struct PokemonDetails: Decodable {
    let types: [PokemonType]
    
    struct PokemonType: Decodable {
        let type: TypeDetail
        struct TypeDetail: Decodable {
            let name: String
        }
    }
}

