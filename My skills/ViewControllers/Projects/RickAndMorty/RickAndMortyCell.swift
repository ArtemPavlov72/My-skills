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
    
    //MARK: - Methods
    func configure(with hero: Hero?) {
        heroNameLabel.text = hero?.name
        
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.loadImage(from: hero?.image) else {return}
            DispatchQueue.main.async {
                self.heroImage.image = UIImage(data: imageData)
            }
        }
    }
}
