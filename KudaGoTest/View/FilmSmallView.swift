//
//  FilmSmallView.swift
//  KudaGoTest
//
//  Created by Александр on 14.01.2021.
//

import UIKit

@IBDesignable class FilmSmallView: UIView {
    
    // MARK: - Dependecys
    private var dataFetcherService = DataFetcherService()

    // MARK: - UI
    @IBOutlet weak private var mainLabel: UILabel!
    @IBOutlet weak private var directorLabel: UILabel!
    @IBOutlet weak private var budgetLabel: UILabel!
    @IBOutlet weak private var yearLabel: UILabel!
    @IBOutlet weak private var runningTimeLabel: UILabel!
    @IBOutlet weak private var posterImageView: UIImageView! {
        didSet {
            posterImageView.layer.cornerRadius = 10
            posterImageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak private var indicator: UIActivityIndicatorView! {
        didSet {
            if #available(iOS 13.0, *) {
                indicator.style = .large
            } else if #available(iOS 12.0, *){
                indicator.style = .gray
            }
        }
    }
    
    // MARK: -internal variable
    private var imageURL: URL? {
        didSet {
            posterImageView?.image = nil
            updateUI()
        }
    }
    
    private func updateUI() {
        guard let url = imageURL else { return }
        indicator.startAnimating()
        
        dataFetcherService.fetchImageData(from: url.absoluteString) { (image) in
            guard url == self.imageURL else { return }
            self.posterImageView.image = image
            self.indicator.stopAnimating()
        }

//        ServerManager.shared.getPosterImage(from: url) { (image) in
//            guard url == self.imageURL else { return }
//            self.posterImageView.image = image
//            self.indicator.stopAnimating()
//        } onFailure: { (error) in
//            self.posterImageView.image = UIImage(named: "404.png")
//            guard let error = error else { return }
//            print (error.localizedDescription)
//        }
    }
    
    private func setup() {
        let view = loadFromNib()
        view.frame = bounds
        addSubview(view)
    }
    
    private func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return UIView() }
        return view
    }
    
    public var nibName: String = "FilmSmallView"
    public var film: Film? {
        didSet {
            guard let image = film?.poster?.image else { return }
            self.imageURL = URL(string: image)
            self.mainLabel.text = film?.title
            self.directorLabel.text = "Режиссер: \(film?.director ?? "")"
            self.budgetLabel.text = "Бюджет: \(film?.budget?.budgetFormater(budgetCurrency: film?.budget_currency) ?? "")"
            self.yearLabel.text = "\(film?.year ?? 0000) г."
            self.runningTimeLabel.text = film?.running_time?.timeFormat()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
}
