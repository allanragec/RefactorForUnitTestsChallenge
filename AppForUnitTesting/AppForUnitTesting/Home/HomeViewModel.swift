//
//  HomeViewModel.swift
//  AppForUnitTesting
//
//  Created by Allan Barbosa De Melo on 04/08/23.
//

import Foundation
import FeatureFlag
import Analytics
import Observability

class HomeViewModel {
    private let service: HomeServicing
    private let newFeedService = NewHomeService()
    private let analytics = Analytics()
    private let observability = Observability()
    private let featureFlagService = FeatureFlagService()
    weak var view: HomeDisplayable?
    
    var isNewServiceEnabled: Bool {
        featureFlagService.isEnabled(flag: HomeViewModel.IS_NEW_FEED_SERVICE_ENABLED)
    }
    
    static let IS_NEW_FEED_SERVICE_ENABLED = "IS_NEW_FEED_SERVICE_ENABLED"
    
    init(service: HomeServicing) {
        self.service = service
    }
    
    func handleResult(_ result: [String]) {
        if result.isEmpty {
            view?.showEmptView()
        }
        else {
            view?.showResult(result: result)
        }
    }
    
    fileprivate func fetchOldService() {
        service.fetchFeed { [weak self] result in
            view?.hideLoading()
            switch result {
            case .success(let result):
                analytics.sendEvent(name: "Home.fetchOldService.success", properties: [:])
                handleResult(result)
            case let .failure(error):
                observability.sendHandledError(title: "Home.fetchOldService.failure", properties: ["error": error.localizedDescription])
                analytics.sendEvent(name: "Home.fetchOldService.failure", properties: [:])
                self?.view?.showError()
            }
        }
    }
    
    fileprivate func fetchNewService() {
        newFeedService.fetchFeed { [weak self] result in
            view?.hideLoading()
            switch result {
            case .success(let result):
                analytics.sendEvent(name: "Home.fetchNewService.success", properties: [:])
                handleResult(result)
            case let .failure(error):
                self?.view?.showError()
                observability.sendHandledError(title: "Home.fetchNewService.failure", properties: ["error": error.localizedDescription])
                analytics.sendEvent(name: "Home.fetchNewService.failure", properties: [:])
            }
        }
    }
    
    func loadData() {
        analytics.sendEvent(name: "Home.loadData", properties: [:])
        view?.showLoading()
        
        if isNewServiceEnabled {
            fetchNewService()
        }
        else {
            fetchOldService()
        }
    }
}
