//
//  ViewController.swift
//  AppForUnitTesting
//
//  Created by Allan Barbosa De Melo on 04/08/23.
//

import UIKit

protocol HomeDisplayable: AnyObject {
    func showLoading()
    func hideLoading()
    func showEmptView()
    func showResult(result: [String])
    func showError()
}

class HomeViewController: UIViewController {
    var viewModel: HomeViewModelProtocol
    
    init(viewModel : HomeViewModelProtocol = HomeViewModel(service: HomeService())){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
    }
}

extension HomeViewController: HomeDisplayable {
    func showLoading() {
        print("show loading")
    }
    
    func hideLoading() {
        print("hide loading")
    }
    
    func showEmptView() {
        print("showEmptyView")
    }
    
    func showResult(result: [String]) {
        print("showResult, result is: \(result)")
    }
    
    func showError() {
        print("error for loading")
    }
}
