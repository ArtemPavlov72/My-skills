//
//  CharacterDetailsViewController.swift
//  My skills
//
//  Created by iMac on 20.02.2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var characterImage: UIImageView! {
        didSet {
            characterImage.layer.cornerRadius = characterImage.frame.height / 2
        }
    }
    
    @IBOutlet var characterDetailsLabel: UILabel!
    
    //MARK: - Public Properties
    var hero: Hero!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = hero.name //не забыть задать минимальное значение текста и констрейнты
        
        characterDetailsLabel.text = hero.description
        loadImage(from: hero.image)
    }
    
    //MARK: - Private Methods
    private func loadImage(from url: String) {
        DispatchQueue.global().async {
            guard let urlImage = URL(string: url) else {return}
            guard let imageData = try? Data(contentsOf: urlImage) else {return}
            
            DispatchQueue.main.async {
                self.characterImage.image = UIImage(data: imageData)
            }
        }
    }
}
