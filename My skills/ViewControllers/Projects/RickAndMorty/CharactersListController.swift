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
    private var filteredHero: [Hero] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 90
        setupSearchController()
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
        isFiltering ? filteredHero.count : rickAndMorty?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rickMortyCell", for: indexPath) as! RickAndMortyCell
        let hero = isFiltering ? filteredHero[indexPath.row] : rickAndMorty?.results[indexPath.row]
        cell.configure(with: hero)
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let hero = isFiltering ? filteredHero[indexPath.row] : rickAndMorty?.results[indexPath.row]
        guard let characterVC = segue.destination as? CharacterDetailsViewController else {return}
        characterVC.hero = hero
    }
    
    // MARK: - Private methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
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

// MARK: - UISearchResultsUpdating
extension CharactersListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredHero = rickAndMorty?.results.filter { hero in
            hero.name.lowercased().contains(searchText.lowercased())
        } ?? []
        tableView.reloadData()
    }
}


