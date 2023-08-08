//
//  HomeViewModel.swift
//  AppForUnitTesting
//
//  Created by Allan Barbosa De Melo on 04/08/23.
//

import Foundation

protocol HomeViewModelProtocol {
    func loadData()
}

class HomeViewModel: HomeViewModelProtocol {
    private let service: HomeServiceProtocol
    weak var view: HomeDisplayable?
    
    init(service: HomeServiceProtocol) {
            self.service = service
    }
    
    func loadData() {
        view?.showLoading()
        service.fetchFeed { [weak self] result in
            self?.view?.hideLoading()
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
