//
//  MainTableViewController.swift
//  KudaGoTest
//
//  Created by Александр on 13.01.2021.
//

import UIKit



class MainTableViewController: UITableViewController {
    
    private let server = ServerManager.shared

    private var films: [Film] = []
    
    var count = 0
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getFilmList(from: "https://kudago.com/public-api/v1.4/movies")
    }

    // MARK: - Data Functions
    private func getFilmList(from url: String) {
        server.getFilmsList (from: url) { [unowned self] (filmList) in
            guard let films = filmList.results else { return }
            var insertedIndexPaths: [IndexPath] = []
            let insertRange = self.films.count..<films.count + self.films.count
            for i in insertRange {
                insertedIndexPaths.append(IndexPath(row: i, section: 0))
            }
            // update table
            DispatchQueue.main.async {
                self.films.append(contentsOf: films)
                self.tableView.performBatchUpdates({
                    self.tableView.insertRows(at: insertedIndexPaths, with: .top)
                }) { (completion) in
                    if completion && filmList.next != nil {
                       // getFilmList(from: filmList.next!)
                        // закомментил изза слабого компа. Очень тупит, когда пытается загрузить 4к объектов.
                        // загрузка с сервера идет постранично.
                    }
                }
            }
        } onFailure: { (error) in
            guard let error = error else { return }
            print (error.localizedDescription)
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
}
