//
//  CollectionViewCellModel.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

protocol SectionModelLogic {
    var cells: [CellModelLogic] {get}
}

protocol CellModelLogic {
    var nibName: String {get}
    var reuseId: String {get}
    var model: Any? {get}
}

protocol CellBinder {
    func bind(_ model: CellModelLogic)
}


class SectionModel: SectionModelLogic {
    var cells: [CellModelLogic]
    
    init(cells: [CellModelLogic]) {
        self.cells = cells
    }
}

class CellModel: CellModelLogic {
    var nibName: String
    var reuseId: String
    var model: Any?
    
    internal init(nibName: String, reuseId: String, model: Any? = nil) {
        self.nibName = nibName
        self.reuseId = reuseId
        self.model = model
    }
}
