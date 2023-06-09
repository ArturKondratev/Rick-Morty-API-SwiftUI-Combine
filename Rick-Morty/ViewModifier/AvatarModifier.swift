//
//  AvatarModifier.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 03.06.2023.
//

import SwiftUI

struct AvatarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: 80, maxHeight: 80)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .cornerRadius(8)
            .shadow(color: .black, radius: 5, x: 3, y: 0)
            .aspectRatio( contentMode: .fill)
    }
}

extension View {
    func avatarModifier() -> some View {
        self.modifier(AvatarModifier())
    }
}
