//
//  EpisodesView.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 01.06.2023.
//

import SwiftUI
import Combine

struct EpisodesView: View {
    
    @ObservedObject var viewModel: EpisodesViewModel
    
    init(viewModel: EpisodesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return NavigationView {
            List {
                ForEach(self.viewModel.episodes) { episode in
                    NavigationLink {
                        EpisodeDescriptionView(episode: episode)
                    } label: {
                        EpisodesViewCell(episode: episode)
                    }
                }
            }
            .navigationTitle("Episodes")
        }
        .onAppear {
            viewModel.fetchEpisodes()
            
        }
    }
}
