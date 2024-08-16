//
//  PokedexDetailView.swift
//  Pokedex
//
//  Created by Jamerson Macedo on 16/08/24.
//

import SwiftUI

struct PokedexDetailView: View {
    var pokemon : Pokemon
    var body: some View {
        ZStack(){
            
            if let imageUrl = pokemon.imageUrl {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400, height: 400)
                } placeholder: {
                    ProgressView()
                }
            }
            
        }.background(pokemon.primaryColor())
    }
}

#Preview {
    PokedexDetailView(  pokemon:
                            Pokemon(
                                name: "Pikachu",
                                url: "https://pokeapi.co/api/v2/pokemon/25/",
                                types: [
                                    Pokemon.PokemonType(type: Pokemon.PokemonType.TypeDetail(name: "electric"))
                                ]
                            )
    )
}
