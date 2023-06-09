//
//  EpisodeDescriptionViewModel.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 03.06.2023.
//

import Foundation
import Combine

class EpisodeDescriptionViewModel: ObservableObject {
    
    @Published var episode: Episodes
    @Published var characters = [Character]()
    @Published var error: NetworkError? = nil
    
    private var apiClient = APIClient()
    var cancellable = Set<AnyCancellable>()
    
    init(episode: Episodes) {
        self.episode = episode
    }
    
    func loadCharacters() {
        for (index, _) in episode.characters.enumerated() {
          if let charURL = URL(string: episode.characters[index]),
            let num = Int(charURL.lastPathComponent) {
              fetchCharacter(num: num)
            }
        }
    }
    
    private func fetchCharacter(num: Int) {
        apiClient
            .character(id: num)
            .receive(on: DispatchQueue.main)
            .sink( receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] character in
                self?.characters.append(character)
            }).store(in: &cancellable)
    }
}
