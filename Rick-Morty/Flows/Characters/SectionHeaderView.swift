//
//  SectionHeaderView.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 31.05.2023.
//

import SwiftUI

struct SectionHeaderView: View {
    let header: String
    let lastUpdateTime: TimeInterval
    let currentData: Date
    
    private var relativeTimeString: String {
        return RelativeDateTimeFormatter()
            .localizedString(fromTimeInterval: lastUpdateTime - currentData.timeIntervalSince1970)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
            Text("last update \(relativeTimeString)")
                .font(.subheadline)
        }
    }
}
