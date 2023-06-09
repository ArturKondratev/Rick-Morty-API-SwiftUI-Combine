//
//  Episodes.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 23.05.2023.
//

import Foundation

public struct Episodes: Codable, Identifiable {
    
    public var id: Int64
    public var name: String
    public var air_date: String
    public var episode: String
    public var characters: [String]
    public var url: String
    
    public init(id: Int64,
                name: String,
                air_date: String,
                episode: String,
                characters: [String],
                url: String) {
        self.id = id
        self.name = name
        self.air_date = air_date
        self.episode = episode
        self.characters = characters
        self.url = url
    }
}
