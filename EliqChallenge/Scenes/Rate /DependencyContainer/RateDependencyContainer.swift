//
//  RateDependencyContainer.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

protocol RateFactory {
    func makeRateViewController(selectedCurrency: Currency) -> RateViewController
}

struct RateDependencyContainer: RateFactory {
    func makeRateViewController(selectedCurrency: Currency) -> RateViewController {
        let viewController = RateViewController(nibName: "RateViewController", bundle: nil)
        let interactor = RateInteractor(currency: selectedCurrency)
        let presenter = RatePresenter()
        let worker = RateWorker(networkManager: AppDelegate.getInstance().networkAPI)
        interactor.worker = worker
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        return viewController
    }
}
