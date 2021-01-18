//
//  URLManager.swift
//  KudaGoTest
//
//  Created by Александр on 18.01.2021.
//

import Foundation

class URLManager {
    
    public static let shared = URLManager()
    
    private init() {}
    
    public func getUrlWithComponents(from url: String,
                                     lang: String? = "",
                                     fields: String? = "",
                                     expand: String? = "",
                                     order_by: String? = "",
                                     text_format: String? = "",
                                     ids: String? = "",
                                     location: String? = "",
                                     premiering_in_location: String? = "",
                                     actual_since: String? = "",
                                     actual_until: String? = ""
    ) -> URL? {
        
        guard var urlComponents = URLComponents(string: url) else { return nil }
        
        let lang = URLQueryItem(name: "lang", value: lang)
        let fields = URLQueryItem(name: "fields", value: fields)
        let expand = URLQueryItem(name: "expand", value: expand)
        let order_by = URLQueryItem(name: "order_by", value: order_by)
        let text_format = URLQueryItem(name: "text_format", value: text_format)
        let ids = URLQueryItem(name: "ids", value: ids)
        let location = URLQueryItem(name: "location", value: location)
        let premiering_in_location = URLQueryItem(name: "premiering_in_location", value: premiering_in_location)
        let actual_since = URLQueryItem(name: "actual_since", value: actual_since)
        let actual_until = URLQueryItem(name: "actual_until", value: actual_until)
        
        var queryItems = [lang,fields,expand,order_by,text_format,text_format,ids,location,premiering_in_location,actual_since,actual_until]
        
        // appending page if url contain it
        if let items = urlComponents.queryItems {
            if let page = items.first(where: { $0.name == "page" }) {
                queryItems.append(page)
            }
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return nil }
        return url
    }
    
}
