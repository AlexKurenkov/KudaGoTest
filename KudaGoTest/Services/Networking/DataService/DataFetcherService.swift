//
//  DataFetcherService.swift
//  KudaGoTest
//
//  Created by Александр on 19.01.2021.
//

import Foundation
import UIKit

class DataFetcherService {
    
    private var dataFetcher: DataFetcher
    private var urlFetcherService = URLFetcherService()
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchFilmList(from url: String, completion: @escaping (FilmsList?) -> ()) {
        guard let url = urlFetcherService.fetchStandartFilmListURL(from: url)?.absoluteString else { return }
        dataFetcher.fetchDecodeData(from: url) { (result: Result<FilmsList?,Error>) in
            switch result {
            case .success(let filmList): completion(filmList)
            case .failure(let error): print (error.localizedDescription)
            }
        }
    }
    
    func fetchImageData(from url: String, completion: @escaping (UIImage?) -> ()) {
        dataFetcher.fetchData(from: url) { (result) in
            switch result {
            case .success(let data): completion(UIImage(data: data))
            case .failure(let error):
                print (error.localizedDescription)
                completion(UIImage.image404())
            }
        }
    }
    
}
