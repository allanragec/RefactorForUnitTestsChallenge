//
//  HomeViewModelTests.swift
//  AppForUnitTestingTests
//
//  Created by Allan Barbosa De Melo on 15/08/23.
//

import XCTest
@testable import AppForUnitTesting


final class HomeViewModelTests: XCTestCase {
    
    // Input for tests
    private var serviceMock = HomeServiceMock()
    
    // Output for tests
    private var spy = HomeSpy()
    
    private lazy var sut: HomeViewModel = {
        let viewModel = HomeViewModel(service: serviceMock)
        viewModel.view = spy
        return viewModel
    }()
    
    func testLoadData_WhenServiceFails_ShouldShowError() {
        // When
        serviceMock.expectedResult = .failure(CustomError.genericError)
        // Invoke
        sut.loadData()
        // Should
        XCTAssertEqual(spy.showLoadingCount, 1)
        XCTAssertEqual(spy.hideLoadingCount, 1)
        XCTAssertEqual(spy.showErrorCount, 1)
        XCTAssertEqual(spy.showResultValues.count, 0)
        XCTAssertEqual(spy.showEmptyViewCount, 0)
    }
    
    func testLoadData_WhenServiceReturnsEmpty_ShouldShowEmptyView() {
        // When
        serviceMock.expectedResult = .success([])
        // Invoke
        sut.loadData()
        // Should
        XCTAssertEqual(spy.showLoadingCount, 1)
        XCTAssertEqual(spy.hideLoadingCount, 1)
        XCTAssertEqual(spy.showErrorCount, 0)
        XCTAssertEqual(spy.showResultValues.count, 0)
        XCTAssertEqual(spy.showEmptyViewCount, 1)
    }
    
    func testLoadData_WhenServiceReturnsSomeValues_ShouldShowResults() throws {
        // When
        let expectedResults = ["abc", "yz"]
        serviceMock.expectedResult = .success(expectedResults)
        // Invoke
        sut.loadData()
        // Should
        XCTAssertEqual(spy.showLoadingCount, 1)
        XCTAssertEqual(spy.hideLoadingCount, 1)
        XCTAssertEqual(spy.showErrorCount, 0)
        XCTAssertEqual(spy.showResultValues.count, 1)
        let values = try XCTUnwrap(spy.showResultValues.first)
        XCTAssertEqual(values, expectedResults)
        XCTAssertEqual(spy.showEmptyViewCount, 0)
    }

}

class HomeServiceMock: HomeServicing {
    var expectedResult: FeedResult = .failure(CustomError.genericError)
    func fetchFeed(completion: (FeedResult) -> Void) {
        completion(expectedResult)
    }
}

fileprivate class HomeSpy: HomeDisplayable {
    var showLoadingCount = 0
    var hideLoadingCount = 0
    var showEmptyViewCount = 0
    var showResultValues: [[String]] = []
    var showErrorCount = 0
    
    func showLoading() {
        showLoadingCount += 1
    }
    
    func hideLoading() {
        hideLoadingCount += 1
    }
    
    func showEmptView() {
        showEmptyViewCount += 1
    }
    
    func showResult(result: [String]) {
        showResultValues.append(result)
    }
    
    func showError() {
        showErrorCount += 1
    }
}

enum CustomError: Error {
    case genericError
}
