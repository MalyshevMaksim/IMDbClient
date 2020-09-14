//
//  ComingCollectionViewController.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/14/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class NewMovieCollectionViewController: UICollectionViewController {
    var presenter: NewMoviePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.register(NewMovieCollectionCell.self, forCellWithReuseIdentifier: NewMovieCollectionCell.reuseIdentifier)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.isPagingEnabled = true
        collectionView.decelerationRate = .fast
        collectionView.alwaysBounceHorizontal = true
    }
}

extension NewMovieCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewMovieCollectionCell.reuseIdentifier, for: indexPath) as! NewMovieCollectionCell
        cell.backgroundColor = .orange
        return cell
    }
}

extension NewMovieCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.9, height: collectionView.frame.width * 0.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension NewMovieCollectionViewController: ViewControllerProtocol {
    func success() {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        
    }
}
