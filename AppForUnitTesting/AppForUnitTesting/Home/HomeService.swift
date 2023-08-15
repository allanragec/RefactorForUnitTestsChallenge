//
//  HomeService.swift
//  AppForUnitTesting
//
//  Created by Allan Barbosa De Melo on 04/08/23.
//

import Foundation

protocol HomeServicing {
    typealias FeedResult = Result<[String], Error>
    func fetchFeed(completion: (FeedResult) -> Void)
}

class HomeService: HomeServicing {
    func fetchFeed(completion: (FeedResult) -> Void) {
        print("HomeService.fetchFeed can't be executed during tests")
        
        let result = [
            "option A",
            "option B",
            "option C",
            "option D"
        ]
        
        completion(Bool.random() ? .success(result) : .failure(CustomErrors.generic))
    }
}
