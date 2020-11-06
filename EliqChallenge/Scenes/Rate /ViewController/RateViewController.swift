//
//  RateViewController.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import UIKit

protocol RateDisplayLogic: class {
    func displayRateChart(viewModel: RateModel.FetchRates.ViewModel)
    func displayDailyRate(viewModel: RateModel.FetchDailyRate.ViewModel)
    func dispalyPageTitle(viewModel: RateModel.Initialize.ViewModel)
}

class RateViewController: UIViewController {
    var interactor: RateInteractorLogic?
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var barChart: BarChart!
    @IBOutlet weak var dailyRateValue: UILabel!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            self.nextButton.isEnabled = false
            self.nextButton.alpha = 0.5
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.initialize(request: .init())
        interactor?.fetchRates(request: .init())
        interactor?.fetchDailyRate(request: .init())
    }
    
}

extension RateViewController: RateDisplayLogic {
    func displayRateChart(viewModel: RateModel.FetchRates.ViewModel) {
        self.barChart.updateDataEntries(dataEntries: viewModel.dataEtries)
    }
    
    func displayDailyRate(viewModel: RateModel.FetchDailyRate.ViewModel) {
        self.date.text = viewModel.date
        self.dailyRateValue.text = viewModel.rateValue
        self.nextButton.isEnabled = viewModel.isNextButtonEnable
        if !viewModel.isNextButtonEnable {
            self.nextButton.alpha = 0.5
        } else {
            self.nextButton.alpha = 1.0
        }
    }
    
    func dispalyPageTitle(viewModel: RateModel.Initialize.ViewModel) {
        self.title = viewModel.pageTitle
        
    }
}

extension RateViewController {
    @IBAction func nextButtonTapped() {
        self.interactor?.nextButtionTapped(request: .init())
    }
    
    @IBAction func previousButtonTapped() {
        self.interactor?.previousButtonTapped(request: .init())
    }
}
