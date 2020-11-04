//
//  Types.swift
//  URM
//
//  Created by Mahsa on 4/27/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public enum AuthType {
    case none
    case bearer

    public var value: String? {
        switch self {
        case .none: return nil
        case .bearer: return "Bearer"
        }
    }
}

public enum RequestType {
    case requestRaw(Data)
    case requestPlain
    case requestJSONEncodable(Encodable)
}

protocol RequestProtocol {
    var baseURL: URL {get}
    var relativePath: String {get}
    var method: HTTPMethod {get}
    var headers: [String: String]? {get}
    var authorizationType: AuthType {get}
    var requestType: RequestType {get}
}

extension RequestProtocol {
    var authorizationType: AuthType {
        return .bearer
    }
}

extension URL {
    init(target: RequestProtocol) {
        if target.relativePath.isEmpty {
            self = target.baseURL
        } else {
            self = target.baseURL.appendingPathComponent(target.relativePath)
        }
    }

}

internal extension URLRequest {
    mutating func encoded(encodable: Encodable, encoder: JSONEncoder = JSONEncoder()) throws -> URLRequest {
        do {
            let encodable = AnyEncodable(encodable)
            httpBody = try encoder.encode(encodable)

            let contentTypeHeaderName = "Content-Type"
            if value(forHTTPHeaderField: contentTypeHeaderName) == nil {
                setValue("application/json", forHTTPHeaderField: contentTypeHeaderName)
            }

            return self
        } catch {
            throw NetworkError.encodableMapping
        }
    }
}


struct AnyEncodable: Encodable {

    private let encodable: Encodable

    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }

    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}

extension HTTPURLResponse {
  @objc var isSuccessful: Bool {
    return (200..<300).contains(statusCode)
  }

  @objc var statusCodeDescription: String {
    return HTTPURLResponse.localizedString(forStatusCode: statusCode)
  }

  var textEncoding: String.Encoding? {
    guard let encodingName = textEncodingName else { return nil }

    return String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding(encodingName as CFString)))
  }
}
