import Foundation
import Alamofire

class PokemonRepository {
    var pokemons: [Pokemon] = []
    
    func getPokemons(completion: @escaping ([Pokemon], String?) -> Void) {
        let url = "https://pokeapi.co/api/v2/pokemon?limit=1000"
        
        AF.request(url, method: .get).validate().responseDecodable(of: PokemonResponse.self) { [weak self] response in
            switch response.result {
            case .success(let pokemonResponse):
                // Fetch details for each Pokémon
                self?.fetchPokemonDetails(pokemonSummaries: pokemonResponse.results, completion: completion)
                
            case .failure(let error):
                print("Error fetching Pokémon: \(error.localizedDescription)")
                completion([], error.localizedDescription)
            }
        }
    }
    
    private func fetchPokemonDetails(pokemonSummaries: [PokemonSummary], completion: @escaping ([Pokemon], String?) -> Void) {
        let dispatchGroup = DispatchGroup()
        var detailedPokemons: [Pokemon] = []
        
        for summary in pokemonSummaries {
            dispatchGroup.enter()
            
            AF.request(summary.url).validate().responseDecodable(of: PokemonDetails.self) { response in
                switch response.result {
                case .success(let details):
                    // Convert PokemonDetails.PokemonType to Pokemon.PokemonType
                    let pokemonTypes: [Pokemon.PokemonType] = details.types.map { pokemonType in
                        Pokemon.PokemonType(type: Pokemon.PokemonType.TypeDetail(name: pokemonType.type.name))
                    }
                    
                    // Create a Pokemon object with the fetched details
                    let pokemon = Pokemon(name: summary.name, url: summary.url, types: pokemonTypes)
                    
                    // Check if the Pokémon has an image and add it to the list
                    if let _ = pokemon.imageUrl {
                        detailedPokemons.append(pokemon)
                    }
                    
                case .failure(let error):
                    print("Error fetching details for Pokémon \(summary.name): \(error.localizedDescription)")
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(detailedPokemons, nil)
        }
    }
}
