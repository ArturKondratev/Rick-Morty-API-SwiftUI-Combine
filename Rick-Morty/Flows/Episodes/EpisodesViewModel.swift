//
//  EpisodesViewModel.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 03.06.2023.
//

import SwiftUI
import Combine

class EpisodesViewModel: ObservableObject {
    
    @Published var episodes = [Episodes]()
    @Published var error: NetworkError? = nil
    
    private var apiClient = APIClient()
    private var currentPage: Int = 1
    
    var cancellable = Set<AnyCancellable>()
    
    func fetchEpisodes() {
        apiClient
            .getEpisodes()
            .receive(on: DispatchQueue.main)
            .sink( receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] epi in
                
                self?.episodes.append(contentsOf: epi.results)
            }).store(in: &cancellable)
    }
    
    
    
    
}
