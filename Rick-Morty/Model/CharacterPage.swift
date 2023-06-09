//
//  CharacterPage.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 22.05.2023.
//

import Foundation

public struct CharacterPage: Codable {
    
    public var info: PageInfo
    public var results: [Character]
    
    public init(info: PageInfo, results: [Character]) {
        self.info = info
        self.results = results
    }
}

