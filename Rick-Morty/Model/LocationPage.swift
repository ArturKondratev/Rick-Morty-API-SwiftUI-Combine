//
//  LocationPage.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 23.05.2023.
//

import Foundation

public struct LocationPage: Codable {
    
    public var info: PageInfo
    public var results: [Locations]
    
    public init(info: PageInfo, results: [Locations]) {
        self.info = info
        self.results = results
    }
}
