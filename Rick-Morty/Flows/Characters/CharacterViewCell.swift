//
//  CharacterViewCell.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 31.05.2023.
//

import SwiftUI
import Kingfisher


struct CharacterViewCell: View {
    
    var character: Character
    
    var body: some View {
        VStack {
            KFImage(URL(string: character.image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
            
            Text(character.name)
                .multilineTextAlignment(.center)
                .font(.title)
        }
    }
}
