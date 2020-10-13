//
//  DetailTopMovieViewController.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController, DetailViewControllerProtocol, MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol!
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        for view in view.subviews {
            view.isHidden = true
        }
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
    }
    
    lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = UIColor(red: 24/255, green: 52/255, blue: 77/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
     }()

     lazy var imDbRating: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
        label.textColor = UIColor(red: 110/255, green: 130/255, blue: 144/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
     }()
    
    lazy var starStack: RatingStackView = {
        let starStack = RatingStackView()
        starStack.translatesAutoresizingMaskIntoConstraints = false
        return starStack
    }()
    
    private func makeLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = UIColor(red: 110/255, green: 130/255, blue: 144/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    lazy var releaseDate: UILabel = {
        let label = makeLabel(text: nil)
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor(red: 24/255, green: 52/255, blue: 77/255, alpha: 1)
        return label
    }()
    
    lazy var contentRating: UILabel = {
        let label = makeLabel(text: nil)
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor(red: 24/255, green: 52/255, blue: 77/255, alpha: 1)
        return label
    }()
    
    lazy var length: UILabel = {
        let label = makeLabel(text: nil)
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor(red: 24/255, green: 52/255, blue: 77/255, alpha: 1)
        return label
    }()
    
    lazy var movieLenghtStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(makeLabel(text: "Lenght"))
        stackView.addArrangedSubview(length)
        return stackView
    }()
    
    lazy var contentRatingStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(makeLabel(text: "Rating"))
        stackView.addArrangedSubview(contentRating)
        return stackView
    }()
    
    lazy var releaseDateStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(makeLabel(text: "Release"))
        stackView.addArrangedSubview(releaseDate)
        return stackView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(movieLenghtStack)
        stackView.addArrangedSubview(contentRatingStack)
        stackView.addArrangedSubview(releaseDateStack)
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var storyline: UILabel = {
        let label = UILabel()
        label.text = "Storyline"
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textColor = UIColor(red: 24/255, green: 52/255, blue: 77/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var plot: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor(red: 110/255, green: 130/255, blue: 144/255, alpha: 1)
        label.numberOfLines = .max
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

     let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
     }()
    
    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(poster)
        scrollView.addSubview(movieTitle)
        scrollView.addSubview(imDbRating)
        scrollView.addSubview(starStack)
        scrollView.addSubview(stackView)
        scrollView.addSubview(storyline)
        scrollView.addSubview(plot)
    }
    
    private func setupView() {
        setupSubviews()
        
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            poster.topAnchor.constraint(equalTo: scrollView.topAnchor),
            poster.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            poster.widthAnchor.constraint(equalToConstant: view.bounds.size.width * 0.5),
            poster.heightAnchor.constraint(equalToConstant: view.bounds.size.width * 0.66),
            
            movieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieTitle.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 20),
            
            imDbRating.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10),
            imDbRating.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            starStack.topAnchor.constraint(equalTo: imDbRating.bottomAnchor, constant: 20),
            starStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: starStack.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            storyline.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            storyline.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            plot.topAnchor.constraint(equalTo: storyline.bottomAnchor, constant: 10),
            plot.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            plot.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            plot.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

extension MovieDetailViewController {
    func success() {
        presenter.configureView(view: self)
        for view in view.subviews {
            UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                view.isHidden = false
            })
        }
        activityIndicator.stopAnimating()
    }
    
    func failure(error: Error) {
        print(error)
    }
}
