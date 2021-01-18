//
//  MainTableViewController.swift
//  KudaGoTest
//
//  Created by Александр on 13.01.2021.
//

import UIKit



class MainTableViewController: UITableViewController {
    
    private let server = ServerManager.shared
    private let startURL = "https://kudago.com/public-api/v1.4/movies"
    
    private var films: [Film] = []
    private var nextPage: String?
    private var showedPages: [Int] = []
    
    var count = 0
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getFilmList(from: startURL)
    }
    
    // MARK: - Data Functions
    private func getFilmList(from url: String) {
        server.getFilmsList(from: url) { (result) in
            switch result {
            case .success(let filmList):
                guard let films = filmList.results else { return }
                var insertedIndexPaths: [IndexPath] = []
                let insertRange = self.films.count..<films.count + self.films.count
                for i in insertRange {
                    insertedIndexPaths.append(IndexPath(row: i, section: 0))
                }
                // update table
                DispatchQueue.main.async {
                    self.films.append(contentsOf: films)
                    self.tableView.performBatchUpdates {
                        self.tableView.insertRows(at: insertedIndexPaths, with: .top)
                    } completion: { (completion) in
                        if completion { self.nextPage = filmList.next }
                    }
                }
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
    }
    
    
    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: mainTableViewCellIdentifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.setFilm(films[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.width
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let film = films[indexPath.row]
        let controller = DetailViewController(film: film)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let condition = ((indexPath.row + 1) % 20 == 0 && !showedPages.contains(indexPath.row) && nextPage != nil)
        if condition {
            getFilmList(from: nextPage!)
            showedPages.append(indexPath.row)
            print ("where here")
        }
    }
}
