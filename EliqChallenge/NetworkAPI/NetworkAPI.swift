//
//  NetworkAPI.swift
//  URM
//
//  Created by Mahsa on 4/28/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import Foundation

class NetworkAPI {
    private let session: URLSession = URLSession(configuration: .default)
    let decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }
    
    private func sendNetworkRequest(request: URLRequest, completionHandler: @escaping (Result<Response, NetworkError>) -> Void) {
        debugPrint("request: \(request.url)")
        let dataTask = self.session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completionHandler(.failure(NetworkError.requestFailed(data, nil, error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                fatalError("Response should be an HTTPURLResponse")
            }
            if !httpResponse.isSuccessful {
                completionHandler(.failure(NetworkError.requestFailed(data, httpResponse, error)))
                return
            }
            guard let data = data else {
                completionHandler(.failure(NetworkError.noData(httpResponse)))
                return
            }
            debugPrint("RESPONSE RECIEVED ----------------")
            debugPrint(String(data: data, encoding: .utf8))
            let response = Response(statusCode: httpResponse.statusCode, data: data, request: request, response: httpResponse)
            completionHandler(.success(response))
        })
        dataTask.resume()
    }
    
    private func updateRequestWithAuthInformaton() {
        
    }
    
    private func send(req: RequestProtocol, completion: @escaping (Result<Response, NetworkError>) -> Void) {
        do {
            let urlRequest = try Endpoint(url: URL(target: req).absoluteString, method: req.method, task: req.requestType, httpHeaderFields: req.headers).urlRequest()
            self.sendNetworkRequest(request: urlRequest, completionHandler: { (result) in
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        } catch {
            completion(.failure(.URLMapping))
        }
    }
        
    private func parse<T: Decodable>(data: Data) -> Result<T, NetworkError> {
        do {
            let object = try decoder.decode(T.self, from: data)
            return .success(object)
        } catch {
            return .failure(.parseError(data, HTTPURLResponse(), nil))
        }
        
    }
    
    public func sendRequest<Request: RequestProtocol, DecodableResponse: Decodable>(request: Request, completion: @escaping (Result<DecodableResponse, NetworkError>) -> Void) {
        self.send(req: request) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let response: DecodableResponse = try? self.parse(data: response.data).get() {
                    completion(.success(response))
                } else {
                    completion(.failure(.parseError(response.data, response.response ?? HTTPURLResponse(), nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func sendRequest<Request: RequestProtocol>(request: Request, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        self.send(req: request) { (result) in
            switch result {
            case .success:
                debugPrint("Network -> Request Succeeded")
                completion(.success(()))
            case .failure(let error):
                debugPrint("Network -> Request failed")
                completion(.failure(error))
            }
        }
    }
    
}
