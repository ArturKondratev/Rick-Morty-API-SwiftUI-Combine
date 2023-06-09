//
//  Rick_MortyTests.swift
//  Rick-MortyTests
//
//  Created by Артур Кондратьев on 05.06.2023.
//

import XCTest
import Combine
@testable import Rick_Morty

class Rick_MortyTests: XCTestCase {
    
    var viewModel: CharactersViewModel!
    var subscriptions: Set<AnyCancellable>!
    
    override func setUp() {
        viewModel = CharactersViewModel()
        subscriptions = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        subscriptions = []
    }
    
    func testFilterText() {
        // Given
        let expected = "Filter: Alive, Female"
        var result = ""
        viewModel.$filterTags
            .sink(receiveValue: { [weak self] _ in
                result = self?.viewModel.filterText ?? "" })
            .store(in: &subscriptions)
        // When
        viewModel.filterTags = [.alive, .female]
        viewModel.filterTags = []
        // Then
        XCTAssert(
            result == expected,
            "Wrong header text. Expected: \(expected), result: \(result)"
        )
    }
    
    func testFilterEmptyText() {
        // Given
        let expected = "All characters"
        var result = ""
        viewModel.$filterTags
            .sink(receiveValue: { [weak self] _ in
                result = self?.viewModel.filterText ?? "" })
            .store(in: &subscriptions)
        // When
        viewModel.filterTags = []
        // Then
        XCTAssert(
            result == expected,
            "Wrong header text. Expected: \(expected), result: \(result)"
        )
    }
    
    func testFilterAllCharactersText() {
        // Given
        let expected = "Filter: Alive, Dead, Female, Genderless, Male"
        var result = ""
        viewModel.$filterTags
            .sink(receiveValue: { [weak self] _ in
                result = self?.viewModel.filterText ?? "" })
            .store(in: &subscriptions)
        // When
        viewModel.filterTags = [.alive, .dead, .female, .genderless, .male]
        viewModel.filterTags = []
        // Then
        XCTAssert(
            result == expected,
            "Wrong header text. Expected: \(expected), result: \(result)"
        )
    }
    
    func testFilteredCharactersList() {
        // Given
        guard let path = Bundle.main.path(forResource: "CharactersPage_1", ofType: "json") else { return }
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let data = try! JSONDecoder().decode(CharacterPage.self, from: jsonData)
        
        let expected: [Character] = data.results.filter({
            $0.gender.lowercased() == Tag.female.rawValue ||
            $0.gender.lowercased() == Tag.male.rawValue
        })
        
        let testViewModel = CharactersViewModelMock()
        let expectation = self.expectation(description: "Characters")
        
        var result: [Character] = []
        testViewModel.$filterTags
            .sink(receiveValue: { [weak testViewModel] _ in
                result = testViewModel?.characters ?? []
            })
            .store(in: &subscriptions)
        
        // When
        testViewModel.testFetchCharacters {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        testViewModel.filterTags = [.female, .male]
        testViewModel.filterTags = []
        // Then
        XCTAssert(
            result.count == expected.count,
            "Expected characters count: \(expected.count); Result characters count:\(result.count)"
        )
        
    }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
