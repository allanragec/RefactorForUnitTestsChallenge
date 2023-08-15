//
//  HomeViewModel.swift
//  AppForUnitTesting
//
//  Created by Allan Barbosa De Melo on 04/08/23.
//

import Foundation

class HomeViewModel {
    private let service: HomeServicing
    weak var view: HomeDisplayable?
    
    init(service: HomeServicing) {
        self.service = service
    }
    
    func loadData() {
        view?.showLoading()
        service.fetchFeed { [weak self] result in
            view?.hideLoading()
            switch result {
            case .success(let result):
                if result.isEmpty {
                    self?.view?.showEmptView()
                }
                else {
                    self?.view?.showResult(result: result)
                }
            case .failure:
                self?.view?.showError()
            }
        }
    }
}
