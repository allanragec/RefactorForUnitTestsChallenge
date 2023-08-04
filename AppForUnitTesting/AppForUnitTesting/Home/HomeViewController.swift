//
//  ViewController.swift
//  AppForUnitTesting
//
//  Created by Allan Barbosa De Melo on 04/08/23.
//

import UIKit

protocol HomeDisplayable: AnyObject {
    func showResult(result: [String])
    func showError()
}

class HomeViewController: UIViewController {
    lazy var viewModel: HomeViewModel = {
        let vm = HomeViewModel()
        vm.view = self
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
    }
}

extension HomeViewController: HomeDisplayable {
    func showResult(result: [String]) {
        print("result is: \(result)")
    }
    
    func showError() {
        print("error for loading")
    }
}
