//
//  LocationViewCell.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 01.06.2023.
//

import SwiftUI

struct LocationViewCell: View {
    let location: Locations
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(self.location.name)")
                .font(.body)
            
            Text("\(self.location.type)")
                .font(.subheadline)
        }
    }
}
