//
//  CharactersViewModelMock.swift
//  Rick-MortyTests
//
//  Created by Артур Кондратьев on 07.06.2023.
//

import Foundation
@testable import Rick_Morty

class CharactersViewModelMock: CharactersViewModel {
    func testFetchCharacters(_ completion: @escaping () -> Void) {
        fetchCharacters()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion()
        }
    }
}
