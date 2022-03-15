//
//  RickAndMortyCell.swift
//  My skills
//
//  Created by Artem Pavlov on 17.02.2022.
//

import UIKit

class RickAndMortyCell: UITableViewCell {
    
    //MARK: - IB Outlets
    @IBOutlet weak var heroImage: HeroImageView! {
        didSet {
            heroImage.layer.cornerRadius = heroImage.frame.height / 2
        }
    }
    @IBOutlet weak var heroNameLabel: UILabel!
    
    //MARK: - Private Outlets
    private var spinnerView: UIActivityIndicatorView?
    
    //MARK: - Methods
    func configure(with hero: Hero?, method: FetchingMethod) {
        heroNameLabel.text = hero?.name
        spinnerView = showSpinner(in: heroImage)
        imageFetchMethod(with: hero?.image ?? "", with: method)
    }
    
    //MARK: - Private Methods
    private func imageFetchMethod(with url: String, with method: FetchingMethod) {
        switch method {
        case .automatic:
            imageFetchAutomatic(from: url)
        case .withAlamofire:
            imageFetchWithAlamofire(from: url)
        case .withCache:
            imageFetchWithCached(from: url)
        }
    }
    
    private func imageFetchAutomatic(from url: String?) {
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.loadImage(from: url) else {return}
            DispatchQueue.main.async {
                self.heroImage.image = UIImage(data: imageData)
                self.spinnerView?.stopAnimating()
            }
        }
    }
    
    private func imageFetchWithAlamofire(from url: String?) {
        if let imageURL = url {
            ImageManager.shared.loadImageWithAlamofire(from: imageURL) { imageData in
                self.heroImage.image = UIImage(data: imageData)
                self.spinnerView?.stopAnimating()
            }
        }
    }
    
    private func imageFetchWithCached(from url: String?) {
        heroImage.fetchImage(from: url ?? "")
        self.spinnerView?.stopAnimating()
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}
