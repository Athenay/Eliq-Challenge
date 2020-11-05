//
//  Endpoint.swift
//  URM
//
//  Created by Mahsa on 4/27/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

open class Endpoint {
    public let url: String
    public let method: HTTPMethod
    public let task: RequestType
    public let httpHeaderFields: [String: String]?

    public init(url: String,
                method: HTTPMethod,
                task: RequestType,
                httpHeaderFields: [String: String]?) {

        self.url = url
        self.method = method
        self.task = task
        self.httpHeaderFields = httpHeaderFields
    }
}

extension Endpoint {
    public func urlRequest() throws -> URLRequest {
        guard let requestURL = URL(string: url) else {
            throw NetworkError.URLMapping
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = httpHeaderFields

        switch task {
        case .requestPlain:
            return request
        case let .requestJSONEncodable(encodable):
            return try request.encoded(encodable: encodable)
        case .requestRaw(let data):
            request.httpBody = data
            return request
        case .requestParameters(urlParameters: let urlParameters):
            request = request.encoded(parameters: urlParameters)
            return request
        }
    }
}


