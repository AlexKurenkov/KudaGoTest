//
//  NetworkDataFetcher.swift
//  KudaGoTest
//
//  Created by Александр on 19.01.2021.
//

import Foundation

protocol DataFetcher {
    func fetchDecodeData<T: Decodable>(from url: String, completion: @escaping (Result<T?,Error>) -> ())
    func fetchData(from url: String, completion: @escaping (Result<Data,Error>) -> ())
}

class NetworkDataFetcher: DataFetcher {
    
    private var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    public func fetchData(from url: String, completion: @escaping (Result<Data,Error>) -> ()) {
        networking.request(from: url) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print ("\(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    public func fetchDecodeData<T: Decodable>(from url: String, completion: @escaping (Result<T?,Error>) -> ()) {
        networking.request(from: url) { (result) in
            switch result {
            case .success(let data):
                let decoded = self.decodeJSON(type: T.self, from: data)
                completion(.success(decoded))
            case .failure(let error):
                print ("\(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        do {
            let object = try decoder.decode(type.self, from: data)
            return object
        } catch let jsonError{
            print ("failed to decode json \(jsonError.localizedDescription)")
            return nil
        }
    }

}
