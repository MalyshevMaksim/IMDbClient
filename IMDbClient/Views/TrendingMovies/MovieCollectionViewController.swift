//
//  ComingCollectionViewController.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewController: UIViewController {
    static let sectionHeaderElementKind = "section-header-element-kind"
    var presenter: MoviePresenterProtocol!
    var collectionView: UICollectionView!
    
    enum Section: String, CaseIterable {
        case inTheaters = "In Theaters"
        case comingSoon = "Coming Soon"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
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
    
    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            return self.makeInThetaresMoviesSection(isWide: isWideView)
        }
        return layout
    }
    
    private func makeInThetaresMoviesSection(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.75))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Show one item plus peek on narrow screens, two items plus peek on wider screens
        let groupFractionalWidth = isWide ? 0.475 : 0.9
        let groupFractionalHeight: Float = isWide ? 0.37 : 0.68
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)), heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: MovieCollectionViewController.sectionHeaderElementKind, alignment: .top)

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}

extension MovieCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetail(section: indexPath.section, from: indexPath)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return presenter.resources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getCountOfMovies(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        presenter.displayCell(cell: cell, section: indexPath.section, forRow: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: MovieCollectionViewController.sectionHeaderElementKind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as! HeaderView
        header.label.text = Section.allCases[indexPath.section].rawValue
        return header
    }
}

extension MovieCollectionViewController: ViewControllerProtocol {
    func success() {
        //collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error)
    }
}
