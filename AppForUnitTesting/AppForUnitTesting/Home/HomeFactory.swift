//
//  HomeFactory.swift
//  AppForUnitTesting
//
//  Created by Allan Barbosa De Melo on 15/08/23.
//

import UIKit

enum HomeFactory {
    static func make() -> UIViewController {
        let service = HomeService()
        let viewModel = HomeViewModel(service: service)
        let viewController = HomeViewController(viewModel: viewModel)
        viewModel.view = viewController
        
        return viewController
    }
}
