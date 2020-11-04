//
//  Response.swift
//  URM
//
//  Created by Mahsa on 4/29/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

class Response {
    public let statusCode: Int
    public let data: Data
    public let request: URLRequest?
    public let response: HTTPURLResponse?
    
    init(statusCode: Int, data: Data, request: URLRequest?, response: HTTPURLResponse?) {
        self.statusCode = statusCode
        self.data = data
        self.request = request
        self.response = response
    }
}
