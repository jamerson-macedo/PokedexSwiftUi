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
                                .shadow(radius: 10)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        
                        // Nome do Pokémon
                        Text(pokemon.name.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding(.horizontal)
                        
                        // Tipo
                        VStack(alignment: .leading) {
                            Text("Tipo(s):")
                                .font(.headline)
                            HStack {
                                ForEach(pokemon.types, id: \.self) { type in
                                    Text(type)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(8)
                                        .font(.body)
                                }
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
                        
                        // Estatísticas Base com Animação de Preenchimento
                        VStack(alignment: .leading) {
                            Text("Estatísticas Base:")
                                .font(.headline)
                            ForEach(pokemon.baseStats.allStats, id: \.name) { stat in
                                HStack {
                                    Text("\(stat.name)").frame(width: 100).padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(Color.blue.opacity(0.1))
                                        .cornerRadius(8)
                                        .font(.body)
                                    GeometryReader { geometry in
                                        ZStack(alignment: .leading) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(height: 10)
                                                .foregroundColor(.gray.opacity(0.3))
                                            
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: min(CGFloat(stat.value) / 255 * geometry.size.width, geometry.size.width), height: 10)
                                                .foregroundColor(.blue)
                                                .animation(.easeInOut(duration: 1), value: stat.value)
                                        }
                                    }
                                    .frame(height: 10)
                                    Text("\(stat.value)")
                                }
                            }
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
#Preview {
    PokemonDetailView(pokemonID: 0)
}
