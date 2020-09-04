//
//  DetailTopMovieViewController.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class DetailMovieController: UIViewController, ViewControllerProtocol {
    var presenter: MoviePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        setupView()
    }
    
    lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.45
        return view
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = UIColor(red: 24/255, green: 52/255, blue: 77/255, alpha: 1)
        return label
    }()
    
    lazy var rating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
        label.textColor = UIColor(red: 110/255, green: 130/255, blue: 144/255, alpha: 1)
        return label
    }()
    
    private func makeLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor(red: 110/255, green: 130/255, blue: 144/255, alpha: 1)
        return label
    }
    
    lazy var releaseDate: UILabel = {
        let label = makeLabel(text: nil)
        label.textColor = UIColor(red: 24/255, green: 52/255, blue: 77/255, alpha: 1)
        return label
    }()
    
    lazy var contentRating: UILabel = {
        let label = makeLabel(text: nil)
        label.textColor = UIColor(red: 24/255, green: 52/255, blue: 77/255, alpha: 1)
        return label
    }()
    
    lazy var movieLenght: UILabel = {
        let label = makeLabel(text: nil)
        label.textColor = UIColor(red: 24/255, green: 52/255, blue: 77/255, alpha: 1)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(makeLabel(text: "Lenght"))
        stackView.addArrangedSubview(makeLabel(text: "Rating"))
        stackView.addArrangedSubview(makeLabel(text: "Release"))
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setupSubviews() {
        view.addSubview(poster)
        view.addSubview(name)
        view.addSubview(rating)
        view.addSubview(stackView)
    }
    
    private func setupView() {
        setupSubviews()
        
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            poster.heightAnchor.constraint(equalToConstant: 280),
            poster.widthAnchor.constraint(equalToConstant: 210),
            poster.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            name.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 25),
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rating.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15),
            rating.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

extension DetailMovieController {
    func success() {
        
    }
    
    func failure(error: Error) {
        print(error)
    }
}
