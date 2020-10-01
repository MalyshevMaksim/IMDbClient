//
//  ComingCollectionViewController.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewController: UICollectionViewController {
    static let sectionHeaderElementKind = "section-header-element-kind"
    var presenter: MoviePresenterProtocol!
    
    enum Section: String, CaseIterable {
        case inTheaters = "In Theaters"
        case comingSoon = "Coming Soon"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        configureCollectionView()
        collectionView.showActivityIndicator()
    }
    
    private func configureCollectionView() {
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: MovieCollectionViewController.sectionHeaderElementKind, withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.decelerationRate = .fast
        collectionView.alwaysBounceHorizontal = true
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
}

extension MovieCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = presenter.resourceDownloader.getCachedMovie(fromSection: indexPath.section, forRow: indexPath.row)
        presenter.showDetail(id: movie!.id)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.resourceDownloader.cache.movieCache.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getCountOfMovies(section: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        let movie = presenter.resourceDownloader.getCachedMovie(fromSection: indexPath.section, forRow: indexPath.row)
        presenter.displayCell(cell: cell, movie: movie!)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: MovieCollectionViewController.sectionHeaderElementKind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as! HeaderView
        header.label.text = Section.allCases[indexPath.section].rawValue
        return header
    }
}

extension MovieCollectionViewController: ViewControllerProtocol {
    func success() {
        collectionView.hideActivityIndicator()
    }
    
    func failure(error: Error) {
        print(error)
    }
}
