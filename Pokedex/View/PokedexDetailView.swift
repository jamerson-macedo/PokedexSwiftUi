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
            Rectangle().foregroundColor(pokemon.primaryColor()).frame(width:.infinity,height: 500).offset(y:-300).opacity(0.3)
            if let imageUrl = pokemon.imageUrl {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle()) // Recorta a imagem em forma de círculo
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 4) // Adiciona uma borda branca
                        )
                        .frame(width: 200, height: 200).offset(y:-230)
                } placeholder: {
                    ProgressView()
                }
            }
            
        }
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
