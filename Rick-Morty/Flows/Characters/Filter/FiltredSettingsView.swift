//
//  FiltredSettingsView.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 31.05.2023.
//

import SwiftUI
import Combine

struct FiltredSettingsView: View {
    
    @State private var tags: [Tag] = []
    @EnvironmentObject var filter: Filter
    @Environment(\.presentationMode) private var presentetionMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Tag.allCases) { tag in
                    Button {
                        self.changeTagState(tag)
                    } label: {
                        HStack {
                            if self.filter.tags.contains(tag) {
                                Image(systemName: "checkmark.circle.fill")
                            }
                            Text(tag.rawValue.capitalized).bold()
                        }
                    }
                }
            }
            .navigationTitle(Text("Select character"))
            .navigationBarItems(trailing: Button("Done"){
                presentetionMode.wrappedValue.dismiss()
            })
            .environmentObject(self.filter)
        }
    }
    
    func changeTagState(_ tag: Tag) {
        filter.tags.contains(tag)
        ? filter.tags.removeAll(where: { $0 == tag })
        : filter.tags.append(tag)
    }
}

