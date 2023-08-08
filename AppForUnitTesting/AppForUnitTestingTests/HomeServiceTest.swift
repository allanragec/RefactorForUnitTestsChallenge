//
//  HomeServiceTest.swift
//  AppForUnitTestingTests
//
//  Created by Maria Estefania Sassone on 07/08/2023.
//

import XCTest
@testable import AppForUnitTesting

class MockHomeService: HomeServiceProtocol {
    var shouldFail = false

    func fetchFeed(completion: @escaping (HomeServiceProtocol.FeedResult) -> Void) {
        if shouldFail {
            completion(.failure(NSError(domain: "TestErrorDomain", code: 1, userInfo: nil)))
        } else {
            let result = [
                "option A",
                "option B",
                "option C",
                "option D"
            ]
            completion(.success(result))
        }
    }
}

final class HomeServiceTest: XCTestCase {
    var homeService: HomeService!
        
        override func setUp() {
            super.setUp()
            homeService = HomeService()
        }

        func testFetchFeedSuccess() {
            let expectation = XCTestExpectation(description: "Fetch feed successful")
            
            homeService.fetchFeed { result in
                switch result {
                case .success(let feed):
                    XCTAssertEqual(feed, ["option A", "option B", "option C", "option D"])
                    expectation.fulfill()
                case .failure:
                    XCTFail("Should not fail for a successful result")
                }
            }
            wait(for: [expectation], timeout: 1.0)
        }

        func testFetchFeedFailure() {
            let expectation = XCTestExpectation(description: "Fetch feed failure")
            
            let mockService = MockHomeService()
            mockService.shouldFail = true
            
            mockService.fetchFeed { result in
                switch result {
                case .success:
                    XCTFail("Should fail for an error result")
                case .failure(let error):
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }
            wait(for: [expectation], timeout: 1.0)
        }
}
