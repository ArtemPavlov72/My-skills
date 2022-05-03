//
//  CharacterDetailsViewController.swift
//  My skills
//
//  Created by Artem Pavlov on 20.02.2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var heroImage: HeroImageView! {
        didSet {
            heroImage.layer.cornerRadius = heroImage.frame.height / 2
        }
    }
    
    @IBOutlet var heroNameLabel: UILabel!
    @IBOutlet var heroDetailsLabel: UILabel!
    
    //MARK: - Public Properties
    var hero: Hero!
    var fetchingMethod = FetchingMethod.automatic
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        
        heroNameLabel.text = hero.name
        heroDetailsLabel.text = hero.description
        imageFetchMethod(from: hero.image, with: fetchingMethod)
    }
    
    // MARK: - Private methods
    private func imageFetchMethod(from url: String?, with method: FetchingMethod) {
        switch method {
        case .automatic:
            getImage(from: url)
        case .withAlamofire:
            getImageWithAlamofire(from: url)
        case .withCache:
            getImageWithCache(from: url)
        case .withAsyncAwait:
            getImage(from: url)
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
    
    private func getImageWithAlamofire(from url: String?) {
        if let imageURL = url {
            ImageManager.shared.loadImageWithAlamofire(from: imageURL) { imageData in
                self.heroImage.image = UIImage(data: imageData)
            }
        }
    }
    
    private func getImageWithCache(from url: String?) {
        heroImage.fetchImage(from: url ?? "")
    }
}
