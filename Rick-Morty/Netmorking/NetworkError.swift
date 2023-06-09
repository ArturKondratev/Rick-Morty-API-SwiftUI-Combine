//
//  NetworkError.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 22.05.2023.
//

import Foundation

enum NetworkError: LocalizedError, Identifiable {
    
    var id: String { localizedDescription }
    
    case unreachableAddress(url: URL)
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .unreachableAddress(let url): return "\(url.absoluteString) is unreachable"
        case .invalidResponse: return "Response with mistake"
        }
    }
}
