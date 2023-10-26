//
//  EpisodeDescriptionCharacterViewCell.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 03.06.2023.
//

import SwiftUI
import Kingfisher

struct EpisodeDescriptionCharacterViewCell: View {
    
    var iconUrl: String
    var name: String
    
    var body: some View {
        HStack {
            KFImage(URL(string: iconUrl))
                .resizable()
                .avatarModifier()
                .padding(10)
                
            Text(name)
                .font(.headline)
            
        }
        .padding(.init(top: 6,
                       leading: 0,
                       bottom: 6,
                       trailing: 0))
    }
}

struct EpisodeDescriptionCharacterViewCell_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDescriptionCharacterViewCell(iconUrl: "qw", name: "123")
    }
}
