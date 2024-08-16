import Foundation

class PokedexViewModel: ObservableObject {
    @Published var pokemons = [Pokemon]()
    
    private let repository: PokemonRepository
    
    @Published var searchText: String = ""
    
    private var allPokemons: [Pokemon] = []
    
    
    init(repository: PokemonRepository = PokemonRepository()) {
        self.repository = repository
       
    }
    
    func getPokemons() {
        repository.getPokemons { [weak self] pokemons, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error: \(error)")
                }
            }
            let filteredPokemons = pokemons.filter { $0.imageUrl != nil }.sorted { $0.id < $1.id}
            
            
            DispatchQueue.main.async {
                
                self?.allPokemons = filteredPokemons
                self?.applySearchFilter()
                print("Lista de pokemons: \(pokemons)")
            }
            
        }
    }
    func applySearchFilter() {
        if searchText.isEmpty {
            pokemons = allPokemons
        } else {
            pokemons = allPokemons.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
