//
//  ExchangeViewController.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import UIKit

protocol ExchangeDisplayLogic {
    func displayConvertResult(viewModel: ExchangeModel.Convert.ViewModel)
    func displayInitializeResult(viewModel: ExchangeModel.Initialize.ViewModel)
}

class ExchangeViewController: UIViewController {
    
    @IBOutlet private weak var fromCurrencyButton: UIButton! {
        didSet {
            self.fromCurrencyButton.layer.addCornerRadius(5)
        }
    }
    @IBOutlet private weak var fromCurrencyValueTextFiled: UITextField! {
        didSet {
            self.fromCurrencyValueTextFiled.keyboardType = .decimalPad
        }
    }
    @IBOutlet private weak var toCurrencyButton: UIButton! {
        didSet {
            self.toCurrencyButton.layer.addCornerRadius(5)
        }
    }
    @IBOutlet private weak var toCurrencyValueTextFiled: UITextField! {
        didSet {
            self.toCurrencyValueTextFiled.keyboardType = .decimalPad
        }
    }
    
    var selectedFrom: Currency = .SEK
    var selectedTo: Currency = .USD
    var supportedCurrencies: [Currency] = []
    var interactor: ExchangeInteractorLogic?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Exchange"
        interactor?.initialize(request: .init())
        self.fromCurrencyValueTextFiled.addTarget(self, action: #selector(self.firstTextfieldDidChanged), for: .editingChanged)
        self.toCurrencyValueTextFiled.addTarget(self, action: #selector(self.secondTextfieldDidChanged), for: .editingChanged)
    }
    
    @objc func firstTextfieldDidChanged(sender: UITextField) {
        requestConvert(sender: .first)
    }
    
    @objc func secondTextfieldDidChanged(sender: UITextField) {
        requestConvert(sender: .second)
    }
}

extension ExchangeViewController: ExchangeDisplayLogic {
    func displayConvertResult(viewModel: ExchangeModel.Convert.ViewModel) {
        if viewModel.reciever == .first {
            self.fromCurrencyValueTextFiled.text = "\(viewModel.to)"
        } else if viewModel.reciever == .second {
            self.toCurrencyValueTextFiled.text = "\(viewModel.to)"
        }
        
    }
    
    func displayInitializeResult(viewModel: ExchangeModel.Initialize.ViewModel) {
        self.supportedCurrencies = viewModel.supportedCurrencies
        self.fromCurrencyButton.setTitle(selectedFrom.rawValue, for: .normal)
        self.toCurrencyButton.setTitle(selectedTo.rawValue, for: .normal)
    }
    
    func requestConvert(sender: EditingTextField) {
        if sender == .first {
            let fromValue = Double(self.fromCurrencyValueTextFiled.text ?? "") ?? 0
            self.interactor?.convert(request: .init(sender: sender, from: selectedFrom, fromValue: fromValue, to: selectedTo))
        } else {
            let fromValue = Double(self.toCurrencyValueTextFiled.text ?? "") ?? 0
            self.interactor?.convert(request: .init(sender: sender, from: selectedTo, fromValue: fromValue, to: selectedFrom))
        }
    }
}

extension ExchangeViewController {
    @IBAction func fromButtonTapped() {
        presentActionSheet { [weak self] (action) in
            guard let self = self else { return }
            guard let title = action.title else { return }
            self.selectedFrom = Currency(rawValue: title)!
            self.fromCurrencyButton.setTitle(self.selectedFrom.rawValue, for: .normal)
            self.requestConvert(sender: .first)
        }
    }
    
    @IBAction func toButtonTapped() {
        presentActionSheet { [weak self] (action) in
            guard let self = self else { return }
            guard let title = action.title else { return }
            self.selectedTo = Currency(rawValue: title)!
            self.toCurrencyButton.setTitle(self.selectedTo.rawValue, for: .normal)
            self.requestConvert(sender: .second)
        }
    }
    
    func presentActionSheet(handler: ((UIAlertAction) -> Void)?) {
        var actions = supportedCurrencies.map {
            return UIAlertAction(title: $0.rawValue, style: .default, handler: handler)
        }
        actions.append(.init(title: "Candel", style: .destructive, handler: nil))
        let alert = UIAlertController(title: "Please select currency", message: nil, preferredStyle: .actionSheet)
        actions.forEach { alert.addAction($0) }
        self.present(alert, animated: true, completion: nil)
    }
}
