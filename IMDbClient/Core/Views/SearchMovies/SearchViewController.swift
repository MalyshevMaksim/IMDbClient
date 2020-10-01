//
//  SearchViewController.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 10/1/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UITableViewController {
    var presenter: MoviePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        filterContentForSearch(searchText: (navigationItem.searchController?.searchBar.text)!)
    }
    
    private func configureNavigationController() {
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchBar.placeholder = "Search Movies"
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func filterContentForSearch(searchText: String) {
        if searchText.isEmpty {
            tableView.backgroundView = SearchEmptyView()
            tableView.separatorStyle = .none
        }
        else {
            presenter.downloadMovies()
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
        tableView.reloadData()
    }
}

extension SearchViewController: ViewControllerProtocol {
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        
    }
}

extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(presenter.getCountOfMovies(section: section))
        return presenter.getCountOfMovies(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter.resourceDownloader.getCachedMovie(fromSection: indexPath.section, forRow: indexPath.row)?.title
        return cell
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearch(searchText: searchController.searchBar.text!)
    }
}
