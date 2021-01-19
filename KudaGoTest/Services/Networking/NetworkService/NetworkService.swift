//
//  NetworkService.swift
//  KudaGoTest
//
//  Created by Александр on 19.01.2021.
//

import Foundation

protocol Networking {
    func request(from url: String, completion: @escaping (Result<Data,Error>) -> ())
}

class NetworkService: Networking {
    
    public func request(from url: String,
                        completion: @escaping (Result<Data,Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    
    private func createDataTask(from request: URLRequest,
                                completion: @escaping (Result<Data,Error>) -> ()) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            // on success
            if let data = data {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
            // on failure
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
}
