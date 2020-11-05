//
//  JSONEncoder.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/5/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

public extension JSONEncoder {
    func getInstance() -> JSONEncoder {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        dateEncodingStrategy = .formatted(formatter)
        keyEncodingStrategy = .convertToSnakeCase
        return self
    }
    
}
