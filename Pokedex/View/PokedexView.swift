//
//  ContentView.swift
//  Pokedex
//
//  Created by Jamerson Macedo on 15/08/24.
//

import SwiftUI

struct PokedexView: View {
    @ObservedObject var viewModel = PokedexViewModel(repository: PokemonRepository())
    @State var textSearch = ""
    var body: some View {
        VStack{
            NavigationView{
                PokemonGridView(pokemons: viewModel.pokemons)
                    .navigationTitle("Pokemons")
                        .searchable(text:$textSearch,prompt: "Buscar pokemon")
                
                
            }
        }.onAppear{
            viewModel.getPokemons()
        }
        
    }
}


#Preview {
    PokedexView()
}
