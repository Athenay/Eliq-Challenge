//
//  ArrayExtension.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/6/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

extension Array {
    func elementAt(index: Int) -> Element? {
        return index < self.count ? self[index] : nil
    }
}
