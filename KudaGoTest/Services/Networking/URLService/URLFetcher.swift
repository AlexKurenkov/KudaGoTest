//
//  URLService.swift
//  KudaGoTest
//
//  Created by Александр on 19.01.2021.
//

import Foundation

protocol URLFetcherProtocol {
    func fetchUrlWithComponents(from url: String, components: [URLQueryItem]) -> URL?
}

class URLFetcher: URLFetcherProtocol {
    
    public func fetchUrlWithComponents(from url: String, components: [URLQueryItem] = []) -> URL? {
        guard var urlComponents = URLComponents(string: url) else { return nil }
        var components = components
        if let items = urlComponents.queryItems {
            if let page = items.first(where: { $0.name == "page" }) {
                components.append(page)
            }
        }
        urlComponents.queryItems = components
        guard let url = urlComponents.url else { return nil }
        return url
    }
    
}
