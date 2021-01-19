//
//  DetailViewController.swift
//  KudaGoTest
//
//  Created by Александр on 13.01.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Data
    private let film: Film
    
    // MARK: - UI
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    private let upperView = FilmSmallView()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = film.body_text
        upperView.film = film
        setupUI(with: film)
    }
    
    // MARK: - UI Methods
    private func setupScrolView() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraits = [
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraits)
    }
    
    private func setupContentView(with film: Film) {
        
        contentView.addSubview(upperView)
        contentView.addSubview(textLabel)
        
        upperView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraits = [
            upperView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            upperView.topAnchor.constraint(equalTo: contentView.topAnchor),
            upperView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            upperView.heightAnchor.constraint(equalTo: upperView.widthAnchor, multiplier: 0.9),
            
            textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            textLabel.topAnchor.constraint(equalTo: upperView.bottomAnchor),
            textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraits)
    }
    
    private func setupUI(with film: Film) {
        setupScrolView()
        setupContentView(with: film)
    }
    
    // MARK: - Initialize with external dependencys
    init(film: Film) {
        self.film = film
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
