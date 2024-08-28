import Foundation
import Combine
class PokedexViewModel: ObservableObject {
    @Published var pokemons = [PokemonBasic]()
    @Published var errorMessage :String? = nil
    @Published var searchText: String = ""
    @Published var isLoading : Bool = false
 
    private let service = PokemonService()
    private var allPokemons: [PokemonBasic] = []
    
    private var cancelable = Set<AnyCancellable>()
    
   
    func getPokemons() {
        isLoading = true
        service.fetchPokemonList().receive(on: DispatchQueue.main).sink{ [weak self] completion in
            self?.isLoading = false
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
           
            
        }receiveValue: { [weak self] pokemons in
            self?.pokemons = pokemons
        }.store(in: &cancelable)
    }
    func applySearchFilter() {
        if searchText.isEmpty {
            pokemons = allPokemons
        } else {
            pokemons = allPokemons.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
