//
//  PageInfo.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 22.05.2023.
//

import Foundation

public struct PageInfo: Codable {
    
    public var count: Int
    public var pages: Int
    public var prev: String?
    public var next: String?
    
    public init(count: Int, pages: Int, prev: String?, next: String?) {
        self.count = count
        self.pages = pages
        self.prev = prev
        self.next = next
    }
}
