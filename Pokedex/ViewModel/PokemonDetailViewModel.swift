//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Jamerson Macedo on 28/08/24.
//

import Foundation
import Combine
class PokemonDetailViewModel : ObservableObject{
    @Published var pokemon : PokemonDetails?
    @Published var isLoading = false
    @Published var errorMessage :String? = nil
    
    private var cancelables = Set<AnyCancellable>()
    private let service = PokemonService()
    
    func fetchPokemonDetail(id : Int){
        isLoading = true
        service.fetchPokemonDetails(id: id).receive(on: DispatchQueue.main).sink {[weak self] completion in
            self?.isLoading = false
            switch completion{
            case .finished:
                break
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        } receiveValue: { pokemon in
            self.pokemon = pokemon
            print(pokemon)
        }.store(in: &cancelables)

    }
}
