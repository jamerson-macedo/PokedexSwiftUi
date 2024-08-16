import Foundation
import SwiftUI

struct Pokemon: Identifiable, Decodable {
    var id: Int {
        Int(url.split(separator: "/").last ?? "") ?? 0
    }
    let name: String
    let url: String
    var types: [PokemonType] = []  // Inicializa como vazio
    
    var imageUrl: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
    
    struct PokemonType: Decodable {
        let type: TypeDetail
        struct TypeDetail: Decodable {
            let name: String
        }
    }
    
    func primaryColor() -> Color {
        // Mapeia tipos de Pokémon para cores
        let colorMapping: [String: Color] = [
            "fire": .red,
            "water": .blue,
            "grass": .green,
            "electric": .yellow,
            "psychic": .purple,
            "ice": .cyan,
            "bug": .green,
            "dragon": .orange,
            "dark": .black,
            "fairy": .pink,
            "fighting": .brown,
            "flying": .blue.opacity(0.5),
            "ghost": .purple,
            "normal": .gray,
            "poison": .purple.opacity(0.7),
            "rock": .brown,
            "steel": .gray
        ]
        
        let primaryType = types.first?.type.name ?? "normal"
        return colorMapping[primaryType, default: .gray]
    }
}

struct PokemonResponse: Decodable {
    let results: [PokemonSummary]
}

struct PokemonSummary: Decodable {
    let name: String
    let url: String
}
