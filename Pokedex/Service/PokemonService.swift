import Foundation
import Combine

class PokemonService {
    private let baseURL = "https://ex.traction.one/pokedex/pokemon"
    
    func fetchPokemonList() -> AnyPublisher<[PokemonBasic], Error> {
        guard let url = URL(string: baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryCompactMap { data, response in
                // Decodificar o JSON manualmente
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                      let jsonDict = jsonObject as? [String: String] else {
                    throw URLError(.cannotParseResponse)
                }
                
                // Mapear o dicionário para um array de PokemonBasic
                let pokemons = jsonDict.compactMap { key, value in
                    if let id = Int(key) {
                        print(value)
                        return PokemonBasic(id: id, name: value)
                    }
                    print(value)
                    return nil
                }
                
                return pokemons
            }
            .eraseToAnyPublisher()
    }
    
    func fetchPokemonDetails(id: Int) -> AnyPublisher<PokemonDetails, Error> {
            let urlString = "\(baseURL)/\(id)"
            guard let url = URL(string: urlString) else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
            .tryCompactMap { data, response in
                    // Decodificar o JSON como um array
                    let pokemonArray = try JSONDecoder().decode([PokemonDetails].self, from: data)
                    guard let pokemon = pokemonArray.first else {
                        throw URLError(.cannotParseResponse)
                    }
                    return pokemon
                }
                .eraseToAnyPublisher()
        }
}
