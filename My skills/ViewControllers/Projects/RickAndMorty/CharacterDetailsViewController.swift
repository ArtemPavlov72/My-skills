//
//  CharacterDetailsViewController.swift
//  My skills
//
//  Created by iMac on 20.02.2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var heroImage: UIImageView! {
        didSet {
            heroImage.layer.cornerRadius = heroImage.frame.height / 2
        }
    }
    
    @IBOutlet var heroNameLabel: UILabel!
    @IBOutlet var heroDetailsLabel: UILabel!
    
    //MARK: - Public Properties
    var hero: Hero!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        
        heroNameLabel.text = hero.name
        heroDetailsLabel.text = hero.description
        loadImage(from: hero.image)
    }
    
    //MARK: - Private Methods
    private func loadImage(from url: String) {
        DispatchQueue.global().async {
            guard let urlImage = URL(string: url) else {return}
            guard let imageData = try? Data(contentsOf: urlImage) else {return}
            
            DispatchQueue.main.async {
                self.heroImage.image = UIImage(data: imageData)
            }
        }
    }
}
