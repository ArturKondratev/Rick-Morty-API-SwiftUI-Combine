//
//  CharactersView.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 31.05.2023.
//

import SwiftUI
import Combine
import Kingfisher
import ASCollectionView

struct CharactersView: View {
    
    @EnvironmentObject var filter: Filter
    @ObservedObject var viewModel: CharactersViewModel
    
    @State private var filterIsPresented: Bool = false
    @State var currentDate: Date = Date()
    
    private var timer = Timer.publish(every: 5, on: .main, in: .common)
        .autoconnect()
        .eraseToAnyPublisher()
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        let filterText: String = viewModel.filterText
        
        return NavigationView {
            List {
                Section(header: SectionHeaderView(header: filterText,
                                                  lastUpdateTime: viewModel.lastUpdateTime,
                                                  currentData: self.currentDate)) {
                    
                    ForEach(self.viewModel.characters) { character in
                        NavigationLink {
                            CharacterDetailsView(character: character)
                        } label: {
                            CharacterViewCell(character: character)
                        }
                    }
                    .onReceive(timer) {
                        self.currentDate = $0
                    }
                    .padding(2)
                }
            }
            .sheet(isPresented: $filterIsPresented) {
                FiltredSettingsView()
                    .environmentObject(self.filter)
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Network error"),
                      message: Text(error.localizedDescription),
                      dismissButton: .cancel())
            }
            .navigationTitle("Characters")
            .navigationBarItems(trailing: Button("Filter") {
                filterIsPresented.toggle()
            })
        }
        .onAppear() {
            viewModel.fetchCharacters()
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(viewModel: CharactersViewModel())
    }
}
