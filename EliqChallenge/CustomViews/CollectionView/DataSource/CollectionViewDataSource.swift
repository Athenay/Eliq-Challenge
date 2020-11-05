//
//  CollectionViewDataSource.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewSelectItemDelegate: class {
    func itemDidSelect(_ model: CellModelLogic, indexPath: IndexPath)
}

class CollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var sections: [SectionModelLogic]
    weak var selectionDelegate: CollectionViewSelectItemDelegate?
    
    init(sections: [SectionModelLogic]) {
        self.sections = sections
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModel = sections[indexPath.section].cells[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.reuseId, for: indexPath)
        (cell as? CellBinder)?.bind(cellModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellModel = self.sections[indexPath.section].cells[indexPath.item]
        selectionDelegate?.itemDidSelect(cellModel, indexPath: indexPath)
    }
}
