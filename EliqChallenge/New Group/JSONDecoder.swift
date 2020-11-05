//
//  JSONDecoder.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

public extension JSONDecoder {
    func getInstance() -> JSONDecoder {
        keyDecodingStrategy = .convertFromSnakeCase
        return self
    }
}
