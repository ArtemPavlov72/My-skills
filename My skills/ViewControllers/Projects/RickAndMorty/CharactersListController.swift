//
//  CharactersListController.swift
//  My skills
//
//  Created by Artem Pavlov on 17.02.2022.
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
    
    //MARK: - Public Properties
    var fetchingMethod = FetchingMethod.automatic
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
        tableView.rowHeight = 90
        setupSearchController()
        fetchingMethod(from: Link.rickAndMorty.rawValue, with: fetchingMethod)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredHero.count : rickAndMorty?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rickMortyCell", for: indexPath) as! RickAndMortyCell
        let hero = isFiltering ? filteredHero[indexPath.row] : rickAndMorty?.results[indexPath.row]
        cell.configure(with: hero, method: fetchingMethod)
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let hero = isFiltering ? filteredHero[indexPath.row] : rickAndMorty?.results[indexPath.row]
        guard let characterVC = segue.destination as? CharacterDetailsViewController else {return}
        characterVC.hero = hero
        characterVC.fetchingMethod = fetchingMethod
    }
    
    // MARK: - IB Actions
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func barButtonNavigation(_ sender: UIBarButtonItem) {
        sender.tag == 1
        ? fetchingMethod(from: rickAndMorty?.info.next ?? "", with: fetchingMethod)
        : fetchingMethod(from: rickAndMorty?.info.prev ?? "", with: fetchingMethod)
    }
    
    // MARK: - Private methods
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func fetchHeroesWithAsync(from url: String) {
        Task {
            do {
                rickAndMorty = try await NetworkManager.shared.fetchDataAsync(from: url)
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private func automaticFetchHeroes(from url: String) {
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let rickAndMorty):
                self.rickAndMorty = rickAndMorty
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    } 
    
    private func fetchHeroesWitAlamofire(from url: String) {
        NetworkManager.shared.fetchDataWithAlamofire(from: url) { result in
            switch result {
            case .success(let rickAndMorty):
                self.rickAndMorty = rickAndMorty
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchingMethod(from url: String, with fetchingMethod: FetchingMethod) {
        switch fetchingMethod {
        case .automatic:
            automaticFetchHeroes(from: url)
        case .withAlamofire:
            fetchHeroesWitAlamofire(from: url)
        case .withCache:
            automaticFetchHeroes(from: url)
        case .withAsyncAwait:
            fetchHeroesWithAsync(from: url)
        }
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


