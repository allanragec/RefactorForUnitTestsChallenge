//
//  HomeService.swift
//  AppForUnitTesting
//
//  Created by Allan Barbosa De Melo on 04/08/23.
//

import Foundation

protocol HomeServiceProtocol {
    typealias FeedResult = Result<[String], Error>
    func fetchFeed(completion: @escaping (FeedResult) -> Void)
}

class HomeService: HomeServiceProtocol {
    
    func fetchFeed(completion: @escaping (FeedResult) -> Void) {
        print("HomeService.fetchFeed can't be executed during tests")
        
        let result = [
            "option A",
            "option B",
            "option C",
            "option D"
        ]
        
        completion(.success(result))
    }
}
