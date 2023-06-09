//
//  ApiClient.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 22.05.2023.
//

import Foundation
import Combine

struct APIClient {
    
    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)
    
    func page(num: Int) -> AnyPublisher<CharacterPage, NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: Method.page(num).url)
            .handleEvents()
            .receive(on: queue)
            .map(\.data)
            .decode(type: CharacterPage.self, decoder: decoder)
            .mapError({ error -> NetworkError in
                switch error {
                case is URLError:
                    return NetworkError.unreachableAddress(url: Method.page(num).url)
                default:
                    return NetworkError.invalidResponse
                }
            })
            .eraseToAnyPublisher()
    }
    
    func character(id: Int) -> AnyPublisher<Character, NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: Method.character(id).url)
            .handleEvents()
            .receive(on: queue)
            .map(\.data)
            .decode(type: Character.self, decoder: decoder)
            .mapError({ error -> NetworkError in
                switch error {
                case is URLError :
                    return NetworkError.unreachableAddress(url: Method.character(id).url)
                default:
                    return NetworkError.invalidResponse
                }
            })
            .eraseToAnyPublisher()
    }
    
    func mergedCharacters(ids: [Int]) -> AnyPublisher<Character, NetworkError> {
        precondition(!ids.isEmpty)
        
        let initialPublisher = character(id: ids[0])
        let remainder = Array(ids.dropFirst())
        
        return remainder.reduce(initialPublisher) { (combined, id) in
            return combined
                .merge(with: character(id: id))
                .eraseToAnyPublisher()
        }
    }
    
    func getEpisodes() -> AnyPublisher<EpisodesPage, NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: Method.episode.url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: EpisodesPage.self, decoder: decoder)
            .retry(3)
            .mapError({ error -> NetworkError in
                switch error {
                case is URLError :
                    return NetworkError.unreachableAddress(url: Method.episode.url)
                default:
                    return NetworkError.invalidResponse
                }
            })
            .eraseToAnyPublisher()
    }
    
    func getLocations() -> AnyPublisher<LocationPage, NetworkError> {
        return URLSession.shared
            .dataTaskPublisher(for: Method.location.url)
            .receive(on: queue)
            .map(\.data)
            .decode(type: LocationPage.self, decoder: decoder)
            .retry(3)
            .mapError({ error -> NetworkError in
                switch error {
                case is URLError :
                    return NetworkError.unreachableAddress(url: Method.location.url)
                default:
                    return NetworkError.invalidResponse
                }
            })
            .eraseToAnyPublisher()
    }
}
