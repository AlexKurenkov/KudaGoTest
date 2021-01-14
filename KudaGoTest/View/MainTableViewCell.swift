//
//  MainTableViewCell.swift
//  KudaGoTest
//
//  Created by Александр on 13.01.2021.
//

import UIKit

public let mainTableViewCellIdentifier = "mainTableViewCellIdentifier"

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var filmsSmalView: FilmSmallView!
    
    public func setFilm(_ film: Film) {
        self.filmsSmalView.film = film
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
