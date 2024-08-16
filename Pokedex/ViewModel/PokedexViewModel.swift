import Foundation

class PokedexViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository = PokemonRepository()) {
        self.repository = repository
        getPokemons()  // Opcional: Buscar dados ao inicializar
    }
    
    func getPokemons() {
        repository.getPokemons { [weak self] pokemons, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error: \(error)")
                }
            }
            let filteredPokemons = pokemons.filter { $0.imageUrl != nil }

            DispatchQueue.main.async {
                
                self?.pokemons = filteredPokemons
                print("Lista de pokemons: \(pokemons)")
            }
        }
    }
}
