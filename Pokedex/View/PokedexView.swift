//
//  ContentView.swift
//  Pokedex
//
//  Created by Jamerson Macedo on 15/08/24.
//

import SwiftUI

struct PokedexView: View {
    @ObservedObject private var viewModel = PokedexViewModel()
    var body: some View {
        NavigationView{
            if viewModel.isLoading {
                ProgressView()
            }else if let errorMessage = viewModel.errorMessage{
                Text("Error \(errorMessage)")
            }else {
                List(viewModel.pokemons){ pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemonID: pokemon.id)){
                        
                        
                        HStack{
                          
                            Text(pokemon.name.capitalized)
                        }
                    }
                }.navigationTitle("Pokemon")
            }
        }.onAppear{
            viewModel.getPokemons()
        }
       
        
    }
    
}



#Preview {
    PokedexView()
}
