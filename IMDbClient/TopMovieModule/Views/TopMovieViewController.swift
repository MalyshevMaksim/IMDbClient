//
//  ViewController.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

class TopMovieViewController: UITableViewController {
    var presenter: TopMoviePresenter!
    let activityIndicator = ActivityIndicatorVew(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupTableView()
        setupActivityIndicator()
    }
    
    // Activity indicator will be displayed until data is downloaded from the Internet
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.start()
    }
    
    private func setupNavigationController() {
        title = "Top Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = UISearchController()
    }
    
    private func setupTableView() {
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseIdentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension TopMovieViewController: MovieViewProtocol {
    func failure(error: Error) {
        print(error)
    }
    
    // After successfully executing the network request and receiving data, we display the table and hide the activit
    func success() {
        UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.tableView.reloadData()
        })
        activityIndicator.stop()
    }
}

extension TopMovieViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getCountOfMovie()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showDetailMovie(from: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier) as? MovieCell else {
            fatalError("12345")
        }
        presenter.showMovie()
        return cell
    }
}
