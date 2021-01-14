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
    
    static let shared = ServerManager()
    private init() { }
    
    public func getFilmsList(from url: String,
                             onSuccess: @escaping (FilmsList) -> (),
                             onFailure: @escaping (Error?) -> ()) {
        
        guard var urlComponents = URLComponents(string: url) else { return }
        
        let lang = URLQueryItem(name: "lang", value: "")
        let fields = URLQueryItem(name: "fields", value: "stars,id,title,poster,year,running_time,director,budget_currency,budget,body_text")
        let expand = URLQueryItem(name: "expand", value: "")
        let order_by = URLQueryItem(name: "order_by", value: "")
        let text_format = URLQueryItem(name: "text_format", value: "")
        let ids = URLQueryItem(name: "ids", value: "")
        let location = URLQueryItem(name: "location", value: "")
        let premiering_in_location = URLQueryItem(name: "premiering_in_location", value: "")
        let actual_since = URLQueryItem(name: "actual_since", value: "")
        let actual_until = URLQueryItem(name: "actual_until", value: "")
        
        var queryItems = [lang,fields,expand,order_by,text_format,text_format,ids,location,premiering_in_location,actual_since,actual_until]
        
        // appending page if url contain it
        if let items = urlComponents.queryItems {
            if let page = items.first(where: { $0.name == "page" }) {
                queryItems.append(page)
            }
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            do {
                let filmsList = try JSONDecoder().decode(FilmsList.self, from: data)
                DispatchQueue.main.async {
                    onSuccess(filmsList)
                }
            } catch {
                print (error.localizedDescription)
                DispatchQueue.main.async {
                    onFailure(error)
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
