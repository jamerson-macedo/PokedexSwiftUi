import SwiftUI

struct PokemonDetailView: View {
    let pokemonID: Int
    @StateObject private var viewModel = PokemonDetailViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Carregando detalhes...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Erro: \(errorMessage)")
            } else if let pokemon = viewModel.pokemon {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Imagem do Pokémon
                        AsyncImage(url: URL(string: pokemon.sprite)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        
                        // Nome do Pokémon
                        Text(pokemon.name.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        // Tipo
                        VStack(alignment: .leading) {
                            Text("Tipo(s):")
                                .font(.headline)
                            ForEach(pokemon.types, id: \.self) { type in
                                Text(type)
                                    .font(.body)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Habilidades
                        VStack(alignment: .leading) {
                            Text("Habilidades:")
                                .font(.headline)
                            ForEach(pokemon.abilities, id: \.name) { ability in
                                Text("\(ability.name): \(ability.description)")
                                    .font(.body)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Estatísticas Base
                        VStack(alignment: .leading) {
                            Text("Estatísticas Base:")
                                .font(.headline)
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("HP: \(pokemon.baseStats.hp)")
                                    Text("Ataque: \(pokemon.baseStats.attack)")
                                    Text("Defesa: \(pokemon.baseStats.defense)")
                                }
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("Sp. Ataque: \(pokemon.baseStats.spAtk)")
                                    Text("Sp. Defesa: \(pokemon.baseStats.spDef)")
                                    Text("Velocidade: \(pokemon.baseStats.speed)")
                                }
                            }
                            .font(.body)
                        }
                        .padding(.horizontal)
                        
                        // Altura e Peso
                        VStack(alignment: .leading) {
                            Text("Altura: \(pokemon.height)")
                                .font(.body)
                            Text("Peso: \(pokemon.weight)")
                                .font(.body)
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 20)
                    }
                }
                .navigationTitle("Detalhes")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchPokemonDetail(id: pokemonID)
        }
    }
}
