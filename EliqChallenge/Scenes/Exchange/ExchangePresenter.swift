//
//  ExchangePresenter.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

protocol ExchangePresenterLogic {
    func presentInitValues(response: ExchangeModel.Initialize.Respone)
    func presentConvertResponse(response: ExchangeModel.Convert.Respone)
}


class ExchangePresenter: ExchangePresenterLogic {
    weak var viewController: ExchangeViewController?
    
    func presentInitValues(response: ExchangeModel.Initialize.Respone) {
        self.viewController?.displayInitializeResult(viewModel: .init(supportedCurrencies: response.supportedCurrencies))
    }
    
    func presentConvertResponse(response: ExchangeModel.Convert.Respone) {
        self.viewController?.displayConvertResult(viewModel: .init(reciever: response.reciever, to: response.to))
    }
    
    
}
