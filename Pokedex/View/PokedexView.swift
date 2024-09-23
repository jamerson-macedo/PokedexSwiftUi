//
//  ContentView.swift
//  Pokedex
//
//  Created by Jamerson Macedo on 15/08/24.
//

import SwiftUI


import SwiftUI

struct PokedexView: View {
    @ObservedObject private var viewModel = PokedexViewModel()
    
    // Definindo 3 colunas com largura fixa
    let columns = [
        GridItem(.fixed(120)),
        GridItem(.fixed(120)),
        GridItem(.fixed(120))
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Carregando Pokémons...")
                        .scaleEffect(1.5)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Erro: \(errorMessage)")
                        .font(.headline)
                        .foregroundColor(.red)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.pokemons) { pokemon in
                                NavigationLink(destination: PokemonDetailView(pokemonID: pokemon.id)) {
                                    VStack {
                                        // Imagem do Pokémon
                                        AsyncImage(url: URL(string: pokemon.spriteUrl)) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100, height: 100)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .background(Color.white.opacity(0.8))
                                        .clipShape(Circle())
                                        .shadow(radius: 5)
                                        
                                        // Nome do Pokémon
                                        Text(pokemon.name.capitalized)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 120, height: 160) // Tamanho fixo do card
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Pokédex")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.getPokemons()
        }
    }
}
#Preview {
    PokedexView()
}
