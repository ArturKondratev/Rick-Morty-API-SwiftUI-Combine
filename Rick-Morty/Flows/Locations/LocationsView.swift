//
//  LocationsView.swift
//  Rick-Morty
//
//  Created by Артур Кондратьев on 01.06.2023.
//

import SwiftUI
import Combine

struct LocationsView: View {
    
    @ObservedObject var viewModel: LocationsViewModel
    
    init(viewModel: LocationsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        return NavigationView {
            List(self.viewModel.locations) { location in
                LocationViewCell(location: location)
            }
            .navigationTitle("Locations")
        }
        .onAppear() {
            viewModel.fetchLocations()
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView(viewModel: LocationsViewModel())
    }
}
