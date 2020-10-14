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
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension MovieCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetail(fromSection: indexPath.section, forRow: indexPath.row)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.movieDownloader.getNumberOfSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getCountOfMovies(section: section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        presenter.displayCell(cell: cell, in: indexPath.section, for: indexPath.row)
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
        self.collectionView.hideActivityIndicator()
    }
    
    func failure(error: Error) {
        print(error)
    }
}
