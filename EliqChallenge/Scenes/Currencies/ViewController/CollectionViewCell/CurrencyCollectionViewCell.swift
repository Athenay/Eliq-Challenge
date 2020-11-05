//
//  CurrencyCollectionViewCell.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var currencyName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
extension CurrencyCollectionViewCell: CellBinder {
    func bind(_ model: CellModelLogic) {
        if let currency = model.model as? Currency {
            self.currencyName.text = currency.rawValue
        }
    }
}
