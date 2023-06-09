//
//  Locations.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 23.05.2023.
//

import Foundation

public struct Locations: Codable, Identifiable {
    
    public var id: Int64
    public var name: String
    public var type: String
    public var residents: [String]
    public var url: String
    public var created: String
    
    public init(id: Int64,
                name: String,
                type: String,
                residents: [String],
                url: String,
                created: String) {
        self.id = id
        self.name = name
        self.type = type
        self.residents = residents
        self.url = url
        self.created = created
    }
}
