//
//  RemoteService.swift
//  NYMostPopularArticles
//
//  Created by Mahmoud Abolfotoh on 04/12/2020.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class RemoteService {
    let session: URLSessionProtocol
    let responseQueue: DispatchQueue?
    
    static let shared = RemoteService(session: URLSession.shared, responseQueue: .main)
    
    init(session: URLSessionProtocol, responseQueue: DispatchQueue?) {
        self.session = session
        self.responseQueue = responseQueue
    }
    
    func dispatch<Type: Decodable>(_ request: URLRequest, completionHandler: @escaping (Result<Type, Error>) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil, let data = data else {
                self.dispatchResult(error: error, completion: completionHandler)
                return
            }
            let decoder = JSONDecoder()
            do {
                let models = try decoder.decode(Type.self, from: data)
                self.dispatchResult(models: models, completion: completionHandler)
            } catch {
                self.dispatchResult(error: error, completion: completionHandler)
            }
        }
        task.resume()
        return task
    }
    
    private func dispatchResult<Type>(models: Type? = nil, error: Error? = nil, completion: @escaping (Result<Type, Error>) -> Void) {
        guard let responseQueue = responseQueue else {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(models!))
            }
            return
        }
        responseQueue.async {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(models!))
            }
        }
    }
}
