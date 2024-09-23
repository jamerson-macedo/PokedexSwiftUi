import Foundation

struct PokemonDetails: Identifiable, Decodable {
    let id: Int
    let name: String
    let sprite: String
    let types: [String]
    let abilities: [Ability]
    let height: String
    let weight: String
    let baseStats: BaseStats

    enum CodingKeys: String, CodingKey {
        case id = "number"
        case name
        case sprite
        case types
        case abilities
        case height
        case weight
        case baseStats
    }
}

struct Ability: Decodable {
    let name: String
    let description: String
    let hidden: Bool
}

struct BaseStats: Decodable {
    let hp: Int
    let attack: Int
    let defense: Int
    let spAtk: Int
    let spDef: Int
    let speed: Int
}

struct PokemonStat: Identifiable {
    let id = UUID()
    let name: String
    let value: Int
}

extension BaseStats {
    var allStats: [PokemonStat] {
        return [
            PokemonStat(name: "HP", value: self.hp),
            PokemonStat(name: "Ataque", value: self.attack),
            PokemonStat(name: "Defesa", value: self.defense),
            PokemonStat(name: "Sp. Ataque", value: self.spAtk),
            PokemonStat(name: "Sp. Defesa", value: self.spDef),
            PokemonStat(name: "Velocidade", value: self.speed)
        ]
    }
}
