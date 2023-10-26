//
//  MainView.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 23.05.2023.
//

import SwiftUI
import Combine

enum Tabs: String {
    case characters = "CharactersView"
    case locations = "Locations"
    case episodes = "Episodes"
}

struct MainView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var selectedTab: Tabs = .characters
    var viewModel: CharactersViewModel
    var filter: Filter
    
    init(viewModel: CharactersViewModel, filter: Filter) {
        self.viewModel = viewModel
        self.filter = filter
    }
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            CharactersView(viewModel: self.viewModel)
                .environmentObject(self.filter)
                .tabItem { Label("Characters", systemImage: "person.3.fill") }
                .tag(Tabs.characters)
                
            
            LocationsView(viewModel: LocationsViewModel())
                .tabItem { Label("Locations", systemImage: "map.fill") }
                .tag(Tabs.locations)
            
            EpisodesView(viewModel: EpisodesViewModel())
                .tabItem { Label("Episodes", systemImage: "tv.fill") }
                .tag(Tabs.episodes)
        }
        .navigationTitle(selectedTab.rawValue)
        .navigationBarBackButtonHidden(true)
        .accentColor(self.colorScheme == .light ? .blue : .orange)
        .foregroundStyle(self.colorScheme == .light ? .blue : .orange)
    }
    
    func CharactersBuilder() -> some View {
        
        var cancellable = Set<AnyCancellable>()
        let filter = Filter()
        let viewModel = CharactersViewModel()
        
        filter.$tags
            .assign(to: \.filterTags, on: viewModel)
            .store(in: &cancellable)
        
        let contentView = CharactersView(viewModel: viewModel)
            .environmentObject(filter)
        return contentView
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
