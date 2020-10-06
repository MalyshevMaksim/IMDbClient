//
//  MovieCollectionViewLayout.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/22/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import UIKit

func generateLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
        let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
        return makeInThetaresMoviesSection(isWide: isWideView)
    }
    return layout
}

func makeInThetaresMoviesSection(isWide: Bool) -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    // Show one item plus peek on narrow screens, two items plus peek on wider screens
    let groupFractionalWidth = isWide ? 0.475 : 0.6
    let groupFractionalHeight: Float = isWide ? 0.4 : 0.9
    
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
