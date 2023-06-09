//
//  EpisodeDescriptionView.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 03.06.2023.
//

import SwiftUI
import Combine

struct EpisodeDescriptionView: View {
    
    @ObservedObject var viewModel: EpisodeDescriptionViewModel
  
    init(episode: Episodes) {
        self.viewModel = EpisodeDescriptionViewModel(episode: episode)
    }
    
    var body: some View {
        List {
            //MARK: - Section 1 Info
            let Section1Text = Text("INFO")
                .font(.body)
            
            Section("\(Section1Text)") {
                ForEach(0..<2) { i in
                    if i == 0 {
                        EpisodeDescriptionInfoViewCell(
                            icon: "tv.circle",
                            info: "Episode",
                            data:  viewModel.episode.episode)
                    }
                    if i == 1 {
                        EpisodeDescriptionInfoViewCell(icon: "calendar.circle",
                                                       info: "Air date",
                                                       data: viewModel.episode.air_date)
                    }
                }
            }
            
            
            //MARK: - Scetion 2 Characters
            let Section2Text = Text("CHARACTERS")
                .font(.body)
            
            Section("\(Section2Text)") {
                ForEach(viewModel.characters) { char in
                    NavigationLink {
                        CharacterDetailsView(character: char)
                    } label: {
                        EpisodeDescriptionCharacterViewCell(iconUrl: char.image,
                                                            name: char.name)
                    }
                }
            }
        }        
        .navigationTitle(self.viewModel.episode.episode)
        .onAppear(){
            viewModel.loadCharacters()
        }
    }
}

//struct EpisodeDescriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        EpisodeDescriptionView()
//    }
//}


