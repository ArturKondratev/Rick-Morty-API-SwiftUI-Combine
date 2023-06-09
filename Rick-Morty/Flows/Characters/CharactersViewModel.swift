//
//  CharactersViewModel.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 31.05.2023.
//

import Foundation
import Combine

class CharactersViewModel: ObservableObject {
    
    @Published private var allCharacters: [Character] = []
    @Published var error: NetworkError? = nil
    @Published var lastUpdateTime: TimeInterval = Date().timeIntervalSince1970
    @Published var filterTags: [Tag] = []
    
    private var apiClient = APIClient()
    private var currentPage: Int = 1
    
    var cancellable = Set<AnyCancellable>()
    
    var filterText: String {
        guard let lastFilter = filterTags.last else {
            return "All characters" }
        
        return filterTags
            .dropLast()
            .reduce(into: "Filter: ") { result, tag in
                result += tag.rawValue.capitalized + ", "
            }
        + lastFilter.rawValue.capitalized
    }
    
    var characters: [Character] {
        guard !filterTags.isEmpty else {
            return allCharacters
        }
        
        return allCharacters
            .filter { (character) -> Bool in
                return filterTags.reduce(false) { (isMatch, tag) -> Bool in
                    self.checkMatching(character: character, for: tag)
                }
            }
    }
    
    func fetchCharacters() {
        apiClient
            .page(num: currentPage)
            .receive(on: DispatchQueue.main)
            .sink( receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] page in
                self?.error = nil
                self?.allCharacters.append(contentsOf: page.results)
                self?.currentPage += 1
                self?.lastUpdateTime = Date().timeIntervalSince1970
            }).store(in: &cancellable)
    }
    
    private func checkMatching(character: Character, for tag: Tag) -> Bool {
        switch tag {
        case .alive, .dead:
            return character.status.lowercased() == tag.rawValue.lowercased()
        case .female, .male, .genderless:
            return character.gender.lowercased() == tag.rawValue.lowercased()
        }
    }
}
