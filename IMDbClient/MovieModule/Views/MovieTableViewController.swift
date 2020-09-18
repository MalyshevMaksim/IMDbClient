//
//  ViewController.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, ViewControllerProtocol {
    var presenter: MoviePresenterProtocol!
    var segmentControl = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationController()
        setupSegmentControl()
    }
    
    private func makeRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        return refreshControl
    }
    
    private func setupTableView() {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = makeRefreshControl()
        tableView.separatorColor = .clear
        tableView.showActivityIndicator()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = UISearchController()
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setupSegmentControl() {
        let items = ["⭐️ Top Rated", "🔥 Most Popular"]
        segmentControl = UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(selected), for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = segmentControl
        segmentControl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    @objc private func selected() {
        tableView.reloadData()
    }
    
    @objc private func refresh(_ sender: Any) {
        presenter.refreshMovies(section: segmentControl.selectedSegmentIndex)
    }
}

extension MovieTableViewController {
    // After successfully executing the network request and receiving data, we display the table and hide the activity
    func success() {
        UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.separatorColor = .none
        })
        self.tableView.reloadData()
        tableView.hideActivityIndicator()
    }
    
    func failure(error: Error) {
        print(error)
    }
}

extension MovieTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCountOfMovies(section: segmentControl.selectedSegmentIndex)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showDetail(section: segmentControl.selectedSegmentIndex, from: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier) as? MovieTableViewCell else {
            fatalError("error")
        }
        presenter.displayCell(cell: cell, section: segmentControl.selectedSegmentIndex, forRow: indexPath.row)
        return cell
    }
}
