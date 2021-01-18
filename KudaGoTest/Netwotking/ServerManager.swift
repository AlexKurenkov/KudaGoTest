//
//  ServerManager.swift
//  KudaGoTest
//
//  Created by Александр on 13.01.2021.
//

import Foundation
import UIKit

// Sigletone to working with API
class ServerManager {
    
    public static let shared = ServerManager()
    private init() { }
    
    public func getFilmsList(from url: String,
                              handler: @escaping (Result<FilmsList, Error>) -> ()) {
        guard let url = URLManager.shared.getUrlWithComponents(from: url,
                                                               fields: "stars,id,title,poster,year,running_time,director,budget_currency,budget,body_text")
        else { return }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            do {
                let filmsList = try JSONDecoder().decode(FilmsList.self, from: data)
                DispatchQueue.main.async {
                    handler(.success(filmsList))
                }
            } catch {
                print (error.localizedDescription)
                DispatchQueue.main.async {
                    handler(.failure(error))
                }
            }
        }).resume()
    
    }
    
    public func getPosterImage(from url: URL,
                               onSuccess: @escaping (UIImage?) -> (),
                               onFailure: @escaping (Error?) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    onSuccess(UIImage(data: data))
                }
            } catch {
                DispatchQueue.main.async {
                    onFailure(error)
                }
            }
        }
    }
    
    
    
}
