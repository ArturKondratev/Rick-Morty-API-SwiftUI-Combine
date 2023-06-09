//
//  Filter.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 31.05.2023.
//

import Foundation
import Combine

enum Tag: String, CaseIterable, Identifiable {
    case alive
    case dead
    case male
    case female
    case genderless
    
    var id: String {
        return self.rawValue
    }
}

class Filter: ObservableObject {
    
    @Published var tags: [Tag] = []
    
    init() {}
}
