//
//  ViewController.swift
//  IMDbAPI
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

class MovieViewController: UITableViewController, ViewControllerProtocol {
    var presenter: MoviePresenterProtocol!
    var segmentControl: UISegmentedControl!
    let activityIndicator = ActivityIndicatorVew(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupTableView()
        setupSegmentControl()
        setupActivityIndicator()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = UISearchController()
    }
    
    private func makeRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        return refreshControl
    }
    
    private func setupTableView() {
        tableView.register(TopMovieCell.self, forCellReuseIdentifier: TopMovieCell.reuseIdentifier)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = makeRefreshControl()
    }
    
    // Activity indicator will be displayed until data is downloaded from the Internet
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.start()
    }
    
    private func setupSegmentControl() {
        let frame = view.bounds
        let items = ["⭐️ Top Rated", "🔥 Most Popular"]
        segmentControl = UISegmentedControl(items: items)
        segmentControl.frame = CGRect(x: frame.minX + 15, y: frame.minY - 50, width: frame.width - 30, height: 35)
        segmentControl.selectedSegmentIndex = 0
        tableView.addSubview(segmentControl)
        tableView.contentInset = UIEdgeInsets(top: segmentControl.frame.height + 15, left: 0, bottom: 0, right: 0)
        segmentControl.addTarget(self, action: #selector(selected(_:)), for: .valueChanged)
    }
    
    @objc private func selected(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    @objc private func refresh(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            presenter.loadTopRatedMovies()
        default:
            presenter.loadMostPopularMovies()
        }
    }
}

extension MovieViewController {
    func failure(error: Error) {
        print(error)
    }
    
    // After successfully executing the network request and receiving data, we display the table and hide the activit
    func success() {
        UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        })
        activityIndicator.stop()
    }
}

extension MovieViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return presenter.topRatedMovies?.count ?? 0
        default:
            return presenter.mostPopularMovies?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tapOnTheMovie(from: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopMovieCell.reuseIdentifier) as? TopMovieCell else {
            fatalError("error")
        }
        let movie: Movie
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            movie = presenter.topRatedMovies![indexPath.row]
        default:
            movie = presenter.mostPopularMovies![indexPath.row]
        }
        
        let lowResolutionPoster = "https://imdb-api.com/images/192x264/"
        let lowResolutionPosterEndpoint = (movie.image as NSString).lastPathComponent
        
        cell.poster.downloadImage(from: lowResolutionPoster + lowResolutionPosterEndpoint)
        cell.title.text = movie.fullTitle
        cell.crew.text = "Crew: \(movie.crew)"
        
        if movie.imDbRating == "" {
            cell.ratingTagView.rating.text = "⭐️  No ratings"
            cell.ratingCount.text = "This film has not yet been released"
        }
        else {
            cell.ratingTagView.rating.text = "⭐️  \(movie.imDbRating) IMDb"
            cell.ratingCount.text = "based on \(movie.imDbRatingCount) user ratings"
        }
        return cell
    }
}
