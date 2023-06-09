//
//  EpisodesPage.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 23.05.2023.
//

import Foundation

public struct EpisodesPage: Codable {
    
    public var info: PageInfo
    public var results: [Episodes]
    
    public init(info: PageInfo, results: [Episodes]) {
        self.info = info
        self.results = results
    }
}
