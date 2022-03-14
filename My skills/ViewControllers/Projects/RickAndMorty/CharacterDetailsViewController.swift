//
//  CharacterDetailsViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 20.02.2022.
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
    var automaticFetch: Bool!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        
        heroNameLabel.text = hero.name
        heroDetailsLabel.text = hero.description
        imageFetchMethod(from: hero.image, with: automaticFetch)
    }
    
    // MARK: - Private methods
    private func imageFetchMethod(from url: String?, with automaticMethod: Bool) {
        if automaticMethod {
            getImage(from: url)
        } else {
            getImagewithAlamofire(from: url)
        }
    }
    
    private func getImage(from url: String?) {
        DispatchQueue.global().async {
            guard let imageData = ImageManager.shared.loadImage(from: url) else {return}
            DispatchQueue.main.async {
                self.heroImage.image = UIImage(data: imageData)
            }
        }
    }
    
    private func getImagewithAlamofire(from url: String?) {
        if let imageURL = url {
            ImageManager.shared.loadImageWithAlamofire(from: imageURL) { imageData in
                self.heroImage.image = UIImage(data: imageData)
            }
        }
    }
}
