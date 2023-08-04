//
//  HomeViewModel.swift
//  AppForUnitTesting
//
//  Created by Allan Barbosa De Melo on 04/08/23.
//

import Foundation

class HomeViewModel {
    private let service = HomeService()
    weak var view: HomeDisplayable?
    
    init() {
        
    }
    
    func loadData() {
        service.fetchFeed { [weak self] result in
            switch result {
            case .success(let result):
                self?.view?.showResult(result: result)
            case .failure:
                self?.view?.showError()
            }
        }
    }
}
