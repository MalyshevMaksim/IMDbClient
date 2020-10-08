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
        configureTableView()
    }
    
    private func configureNavigationController() {
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchBar.placeholder = "Search Movies"
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        tableView.backgroundView = SearchEmptyView()
        tableView.separatorStyle = .none
        tableView.register(SearchMovieCell.self, forCellReuseIdentifier: SearchMovieCell.reuseIdentifier)
    }
    
    private func filterContentForSearch(searchText: String) {
        DispatchQueue.main.async {
            if searchText.isEmpty {
                self.tableView.backgroundView = SearchEmptyView()
                self.tableView.separatorStyle = .none
                self.tableView.hideActivityIndicator()
            }
            else {
                self.tableView.backgroundView = nil
                self.tableView.separatorStyle = .singleLine
                self.tableView.showActivityIndicator()
                self.presenter.delegate.filter(self.navigationItem.searchController!, didChangeSearchText: searchText, in: 0)
            }
        }
    }
}

extension SearchViewController: ViewControllerProtocol {
    func success() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.hideActivityIndicator()
        }
    }
    
    func failure(error: Error) {
        print("ERROR: \(error)")
    }
}

extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return presenter.getCountOfMovies(section: section)
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieCell.reuseIdentifier) as? SearchMovieCell else {
            return UITableViewCell()
        }
        presenter.displayCell(cell: cell, in: indexPath.section, for: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showDetail(fromSection: 0, forRow: indexPath.row)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearch(searchText: searchController.searchBar.text!)
    }
}
