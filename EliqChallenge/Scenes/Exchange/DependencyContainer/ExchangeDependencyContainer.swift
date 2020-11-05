//
//  ExchangeDependencyContainer.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

protocol ExchangeFactory {
    func makeExchangeViewControlelr() -> ExchangeViewController
}

struct ExchangeDependencyContainer: ExchangeFactory {
    func makeExchangeViewControlelr() -> ExchangeViewController {
        let viewController = ExchangeViewController(nibName: "ExchangeViewController", bundle: nil)
        let interactor = ExchangeInteractor(latestCurrencyFetcher: AppDelegate.getInstance().latestCurrencyFetcher)
        let presenter = ExchangePresenter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        return viewController
    }
}
