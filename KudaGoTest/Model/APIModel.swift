//
//  APIModel.swift
//  KudaGoTest
//
//  Created by Александр on 13.01.2021.
//

import Foundation

// MARK: - API document find at https://docs.kudago.com/api/

final class FilmsList: Decodable {
    
    public var count    : Int? //
    public var next     : String? //
    public var previous : String? //
    public var results  : [Film]? //
    
}

final class Film: Decodable {
    
    public var id               : Int? // идентификатор
    public var stars            : String? // актеры
    public var director         : String? // режжисер
    public var title            : String? // название
    public var year             : Int? // год выпуска
    public var running_time     : Int? // продолжительность, min
    public var age_restriction  : String? // возрастное ограничение, year
    public var budget           : Double? // бюджет
    public var budget_currency  : String? // валюта бюджета
    public var poster           : Poster? // постер
    public var body_text        : String? // описание
}

final class Poster: Decodable {
    
    public var image    : String? //
    public var source   : Source? //
    
}

final class Source: Decodable {
    
    public var name     : String? //
    public var link     : String? //
    
}
