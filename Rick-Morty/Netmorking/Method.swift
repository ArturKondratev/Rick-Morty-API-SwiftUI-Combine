//
//  Method.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 22.05.2023.
//

import Foundation

enum Method {
    static let baseURL = URL(string: "https://rickandmortyapi.com/api/")!
    static let characterPath = "character/"
    static let locationPath = "location"
    static let episodePath = "episode"
    
    case page(Int)
    case character(Int)
    case location
    case episode
    
    var url: URL {
        switch self {
        case .page(let num):
            let urlString = Method.baseURL.appendingPathComponent(Method.characterPath).absoluteString
            var urlComps = URLComponents(string: urlString)
            urlComps?.queryItems = [URLQueryItem(name: "page", value: "\(num)")]
            return urlComps?.url ?? Method.baseURL
        
        case .character(let id):
            return Method.baseURL.appendingPathComponent(Method.characterPath + String(id))
        case .location:
            return Method.baseURL.appendingPathComponent(Method.locationPath)
        case .episode:
            return Method.baseURL.appendingPathComponent(Method.episodePath)
        }
    }
}
