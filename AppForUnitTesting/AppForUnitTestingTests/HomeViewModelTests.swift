//
//  HomeViewModelTests.swift
//  AppForUnitTestingTests
//
//  Created by Maria Estefania Sassone on 07/08/2023.
//

import XCTest

import Foundation
@testable import AppForUnitTesting

class MockHomeViewModel: HomeViewModelProtocol {
    var loadDataCalled = false
    var fetchFeedCompletion: ((Result<[String], Error>) -> Void)?

    func loadData() {
        loadDataCalled = true
        fetchFeedCompletion?(.success(["Option A", "Option B", "Option C"]))
    }
}

final class HomeViewModelTests: XCTestCase {
    
    var viewController: HomeViewController!
    var mockViewModel: MockHomeViewModel!

        override func setUp() {
            super.setUp()
            mockViewModel = MockHomeViewModel()
            viewController = HomeViewController(viewModel: mockViewModel)
            viewController.loadViewIfNeeded()
        }

        func testLoadDataCallsViewModel() {
            viewController.viewDidLoad()

            XCTAssertTrue(mockViewModel.loadDataCalled, "loadData should be called")
        }

        func testShowResult() {
            let expectation = XCTestExpectation(description: "Show result expectation")
            mockViewModel.fetchFeedCompletion = { result in
                XCTAssertNotNil(result)
                expectation.fulfill()
            }

            viewController.viewDidLoad()

            wait(for: [expectation], timeout: 1.0)
        }
}
