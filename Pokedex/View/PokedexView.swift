//
//  ContentView.swift
//  Pokedex
//
//  Created by Jamerson Macedo on 15/08/24.
//

import SwiftUI

struct PokedexView: View {
    @ObservedObject var viewModel = PokedexViewModel(repository: PokemonRepository())
    var body: some View {
        VStack{
            NavigationView{
                PokemonGridView(pokemons: viewModel.pokemons)
                    .navigationTitle("Pokemons")
                    .searchable(text:$viewModel.searchText,prompt: "Buscar pokemon") .onChange(of: viewModel.searchText) { _,_ in
                        viewModel.applySearchFilter()
                    }
                        
                        
                    }
            }.onAppear{
                viewModel.getPokemons()
            }
            
        }
        
    }



#Preview {
    PokedexView()
}
