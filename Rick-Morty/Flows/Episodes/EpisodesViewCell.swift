//
//  EpisodesViewCell.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 03.06.2023.
//

import SwiftUI

struct EpisodesViewCell: View {
    
    var episode: Episodes
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.episode.episode + " - " + self.episode.name)
                .font(.subheadline)
            Text(self.episode.air_date)
                .font(.callout)
        }
    }
}

//struct EpisodesViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        EpisodesViewCell()
//    }
//}
