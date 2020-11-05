//
//  CollectionView.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView {
    
    private weak var customDataSource: CollectionViewDataSource? {
        didSet {
//            self.customDataSource?.selectionDelegate = self.selectionDelegate
        }
    }
//    private weak var selectionDelegate: CollectionViewSelectItemDelegate?
    
    func displaySections(_ dataSource: CollectionViewDataSource) {
        self.customDataSource = dataSource
        self.register(dataSource.sections)
        self.dataSource = dataSource
        self.delegate = dataSource
        self.reloadData()
    }
    
    func setSelectionDelegate(_ delegate: CollectionViewSelectItemDelegate) {
        self.customDataSource?.selectionDelegate = delegate
    }
    
    private func register(_ sections: [SectionModelLogic]) {
        sections.forEach { $0.cells.forEach { (cell) in self.register(.init(nibName: cell.nibName, bundle: nil), forCellWithReuseIdentifier: cell.reuseId)}}
    }
    
    
}
