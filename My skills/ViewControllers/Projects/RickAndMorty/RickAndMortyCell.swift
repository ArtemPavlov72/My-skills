//
//  RickAndMortyCell.swift
//  My skills
//
//  Created by iMac on 17.02.2022.
//

import UIKit

class RickAndMortyCell: UITableViewCell {
    
    //MARK: - IB Outlets
    @IBOutlet weak var heroImage: UIImageView! {
        didSet {
            heroImage.layer.cornerRadius = heroImage.frame.height / 2
        }
    }
    @IBOutlet weak var heroNameLabel: UILabel!
    
    //MARK: - Private Outlets
    private var spinnerView: UIActivityIndicatorView?
    
    //MARK: - Methods
    func configure(with hero: Hero?) {
        heroNameLabel.text = hero?.name
        
        spinnerView = showSpinner(in: heroImage)
        
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.loadImage(from: hero?.image) else {return}
            DispatchQueue.main.async {
                self.heroImage.image = UIImage(data: imageData)
                self.spinnerView?.stopAnimating()
            }
        }
    }
    
    //MARK: - Private Methods
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}
