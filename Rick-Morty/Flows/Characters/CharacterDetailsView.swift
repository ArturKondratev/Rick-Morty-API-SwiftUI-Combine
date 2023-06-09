//
//  CharacterDetailsView.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 03.06.2023.
//

import SwiftUI
import Kingfisher
import ASCollectionView

struct CharacterDetailsView: View {
    
    var character: Character
    
    var body: some View {
        
        VStack {
            ScrollView {
                HStack(alignment: .center) {
                    Text(character.name)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Button("...") { }
                }
                .font(.largeTitle)
                KFImage(URL(string: character.image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                VStack {
                    Text("Gender: " + character.gender)
                    Text("Status: " + character.status)
                }
                
                if character.type.isEmpty == false {
                    Text("Type: " + character.type)
                }
            }
        }
        .padding()
    }
}
