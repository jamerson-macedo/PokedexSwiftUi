import SwiftUI

struct PokemonGridView: View {
    let pokemons: [Pokemon]

    // Define o layout de duas colunas
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 16) {
                ForEach(pokemons) { pokemon in
                    VStack(alignment: .center, spacing: 8) {
                        
                        // Exibe a imagem do Pokémon
                        if let imageUrl = pokemon.imageUrl {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        
                        // Nome do Pokémon
                        Text(pokemon.name.capitalized)
                            .font(.headline)
                            .bold()
                            .padding(.bottom, 5)

                        // Lista de tipos como botões
                        ScrollView(.horizontal) {
                            HStack(spacing: 8) {
                                ForEach(pokemon.types, id: \.type.name) { pokemonType in
                                    Text(pokemonType.type.name.capitalized)
                                        .padding(8)
                                        .background(pokemon.primaryColor().opacity(0.1))
                                        .cornerRadius(20)
                                        .foregroundColor(pokemon.primaryColor())
                                        .font(.subheadline)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(pokemon.primaryColor(), lineWidth: 2)
                                        )
                                }
                            }
                        }
                    }
                    .padding()
                    .background(pokemon.primaryColor().opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
            }
            .padding()
        }
    }
}

struct PokemonGridView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonGridView(
            pokemons: [
                Pokemon(
                    name: "Pikachu",
                    url: "https://pokeapi.co/api/v2/pokemon/25/",
                    types: [
                        Pokemon.PokemonType(type: Pokemon.PokemonType.TypeDetail(name: "electric"))
                    ]
                ),
                Pokemon(
                    name: "Bulbasaur",
                    url: "https://pokeapi.co/api/v2/pokemon/1/",
                    types: [
                        Pokemon.PokemonType(type: Pokemon.PokemonType.TypeDetail(name: "grass")),
                        Pokemon.PokemonType(type: Pokemon.PokemonType.TypeDetail(name: "poison"))
                    ]
                )
            ]
        )
    }
}
