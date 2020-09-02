//
//  ViewController.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

class TopMovieViewController: UIViewController {
    var presenter: TopMoviePresenter!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Rated Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func success() {
        tableView.reloadData()
    }
    
    func failrue(error: Error) {
        print(error)
    }
}

extension TopMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.topMovies?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter.topMovies!.items[indexPath.row].title
        return cell
    }
}
