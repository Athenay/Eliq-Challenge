//
//  CurrencyViewController.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import UIKit

protocol CurrencyDisplayLogic: class {
    func displayList(viewModel: CurrencyModel.Fetch.ViewModel)
}

class CurrencyViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: CollectionView! {
        didSet {
            
        }
    }
    var interactor: CurrencyInteractorLogic?
    var router: CurrencyRoutingLogic?
    var dataSource: CollectionViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        interactor?.fetchCurrencies(request: .init())
    }
    
    func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
        layout.itemSize = .init(width: UIScreen.main.bounds.width / 2, height: 120)
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

}

extension CurrencyViewController: CurrencyDisplayLogic {
    func displayList(viewModel: CurrencyModel.Fetch.ViewModel) {
        self.dataSource = CollectionViewDataSource.init(sections: viewModel.sections)
        self.collectionView.displaySections(dataSource)
        self.collectionView.setSelectionDelegate(self)
    }
}


extension CurrencyViewController: CollectionViewSelectItemDelegate {
    func itemDidSelect(_ model: CellModelLogic, indexPath: IndexPath) {
        guard let selectedCurrency = model.model as? Currency else {
            return
        }
        self.router?.navigateToRate(selectedCurrency: selectedCurrency)
    }
}
