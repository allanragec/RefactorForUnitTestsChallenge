//
//  NewHomeService.swift
//  AppForUnitTesting
//
//  Created by Allan Barbosa De Melo on 15/08/23.
//

import Foundation

class NewHomeService {
    typealias NewFeedResult = Result<[String], Error>
    
    func fetchFeed(completion: (NewFeedResult) -> Void) {
        print("NewHomeService.fetchFeed can't be executed during tests")
        
        let result = [
            "option A",
            "option D"
        ]
        
        completion(Bool.random() ? .success(result) : .failure(CustomErrors.generic))
    }
}

enum CustomErrors: Error {
    case generic
}
