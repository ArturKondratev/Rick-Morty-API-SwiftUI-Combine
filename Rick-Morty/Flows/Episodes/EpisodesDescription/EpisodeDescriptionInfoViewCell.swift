//
//  EpisodeDescriptionInfoViewCell.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 03.06.2023.
//

import SwiftUI

struct EpisodeDescriptionInfoViewCell: View {
    
    var icon: String
    var info: String
    var data: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .padding(10)
            Text(info)
            Spacer()
            Text(data)
        }
    }
}
