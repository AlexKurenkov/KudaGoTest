//
//  URLFetcher.swift
//  KudaGoTest
//
//  Created by Александр on 19.01.2021.
//

import Foundation

class URLFetcherService {
    
    private var urlService: URLFetcherProtocol
    
    init(urlService: URLFetcherProtocol = URLFetcher()) {
        self.urlService = urlService
    }
    
    public func fetchFilmListUrl(from url: String,
                                 with lang: String = "",
                                 fields: [Fields] = [],
                                 expand: String = "",
                                 order_by: String = "",
                                 text_format: String = "",
                                 ids: String = "",
                                 location: String = "",
                                 premiering_in_location: String = "",
                                 actual_since: String = "",
                                 actual_until: String = "") -> URL? {
        
        let lang = URLQueryItem(name: "lang", value: lang)
        let fields = URLQueryItem(name: "fields", value: Fields.stringFrom(fields: fields))
        let expand = URLQueryItem(name: "expand", value: expand)
        let order_by = URLQueryItem(name: "order_by", value: order_by)
        let text_format = URLQueryItem(name: "text_format", value: text_format)
        let ids = URLQueryItem(name: "ids", value: ids)
        let location = URLQueryItem(name: "location", value: location)
        let premiering_in_location = URLQueryItem(name: "premiering_in_location", value: premiering_in_location)
        let actual_since = URLQueryItem(name: "actual_since", value: actual_since)
        let actual_until = URLQueryItem(name: "actual_until", value: actual_until)
        
        let queryItems = [lang,fields,expand,order_by,text_format,text_format,ids,location,premiering_in_location,actual_since,actual_until]
        
        return urlService.fetchUrlWithComponents(from: url, components: queryItems)
    }
    
    public func fetchStandartFilmListURL(from url: String) -> URL? {
        fetchFilmListUrl(from: url, fields: [
            .stars,
            .id,
            .title,
            .poster,
            .year,
            .running_time,
            .director,
            .budget_currency,
            .budget,
            .body_text
        ])
    }
    
}

enum Fields: String {
    case stars           = "stars"
    case id              = "id"
    case title           = "title"
    case poster          = "poster"
    case year            = "year"
    case running_time    = "running_time"
    case director        = "director"
    case budget_currency = "budget_currency"
    case budget          = "budget"
    case body_text       = "body_text"
    
    public static func stringFrom(fields: [Fields]) -> String {
        var result = ""
        for field in fields {
            result.append("\(field.rawValue),")
        }
        return result
    }
}
