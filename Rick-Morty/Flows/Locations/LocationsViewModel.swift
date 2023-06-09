//
//  LocationsViewModel.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 04.06.2023.
//

import Combine
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    @Published var error: NetworkError? = nil
    
    var locations = [Locations]()
    var cancellable = Set<AnyCancellable>()
    private var apiClient = APIClient()
    private var currentPage: Int = 1
    
    func fetchLocations() {
        apiClient
            .getLocations()
            .receive(on: DispatchQueue.main)
            .sink( receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] locationsResult in
                self?.error = nil
                self?.locations.append(contentsOf: locationsResult.results)
                self?.currentPage += 1
            }).store(in: &cancellable)
    }
}
