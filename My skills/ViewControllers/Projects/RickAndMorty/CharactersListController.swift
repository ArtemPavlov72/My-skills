//
//  CharactersListController.swift
//  My skills
//
//  Created by iMac on 17.02.2022.
//

import UIKit

class CharactersListController: UITableViewController {
    
    // MARK: - Private Properties
    private var rickAndMorty: RickAndMorty?
  
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 90
        fetchHeroes(from: Link.rickAndMorty.rawValue)
    }
    
    // MARK: - IB Actions
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func barButtonNavigation(_ sender: UIBarButtonItem) {
        sender.tag == 1
        ? fetchHeroes(from: rickAndMorty?.info.next)
        : fetchHeroes(from: rickAndMorty?.info.prev)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rickAndMorty?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rickMortyCell", for: indexPath) as! RickAndMortyCell
        let hero = rickAndMorty?.results[indexPath.row]
        cell.configure(with: hero)
        return cell
    }
}

// MARK: - Networking
extension CharactersListController {
    func fetchHeroes(from url: String?) {
        guard let stringUrl = url else {return}
        guard let url = URL(string: stringUrl) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                self.rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
