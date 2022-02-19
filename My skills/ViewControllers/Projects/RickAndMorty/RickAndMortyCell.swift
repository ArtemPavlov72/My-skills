//
//  RickAndMortyCell.swift
//  My skills
//
//  Created by iMac on 17.02.2022.
//

import UIKit

class RickAndMortyCell: UITableViewCell {
    
    @IBOutlet weak var heroImage: UIImageView! {
        didSet {
            heroImage.layer.cornerRadius = heroImage.frame.height / 2
        }
    }
    
    @IBOutlet weak var heroNameLabel: UILabel!
    
    func configure(with hero: Hero?) {
        heroNameLabel.text = hero?.name
        
        DispatchQueue.global().async {
            guard let url = URL(string: hero?.image ?? "") else {return}
            guard let imageData = try? Data(contentsOf: url) else {return}
            
            DispatchQueue.main.async {
                self.heroImage.image = UIImage(data: imageData)
            }
        }
    }
}
