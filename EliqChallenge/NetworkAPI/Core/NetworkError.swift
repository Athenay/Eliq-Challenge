//
//  NetworkError.swift
//  URM
//
//  Created by Mahsa on 4/27/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case URLMapping
    case encodableMapping
    case requestFailed(Data?, HTTPURLResponse?, Error?)
    case noData(HTTPURLResponse)
    case parseError(Data, HTTPURLResponse, Error?)
    case authenticationError(Error)
}
