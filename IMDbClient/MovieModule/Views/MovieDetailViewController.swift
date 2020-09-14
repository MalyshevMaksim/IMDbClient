//
//  DetailTopMovieViewController.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController, ViewControllerProtocol {
    var presenter: MovieDetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
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
        label.textColor = UIColor(red: 24/255, green: 52/255, blue: 77/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
     }()

     lazy var rating: UILabel = {
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
    
    lazy var movieLenght: UILabel = {
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
        stackView.addArrangedSubview(movieLenght)
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
    
    lazy var story: UILabel = {
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
        scrollView.addSubview(rating)
        scrollView.addSubview(starStack)
        scrollView.addSubview(stackView)
        scrollView.addSubview(storyline)
        scrollView.addSubview(story)
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
            
            movieTitle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            movieTitle.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 20),
            
            rating.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10),
            rating.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            starStack.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 20),
            starStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: starStack.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            storyline.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            storyline.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            story.topAnchor.constraint(equalTo: storyline.bottomAnchor, constant: 10),
            story.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            story.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            story.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

extension MovieDetailViewController {
    func success() {
        presenter.configureView(view: self)
    }
    
    func failure(error: Error) {
        print(error)
    }
}

extension MovieDetailViewController: MovieDetailView {
    func display(image: UIImage?) {
        self.poster.image = image
    }
    
    func display(title: String) {
        self.movieTitle.text = title
    }
    
    func display(imDbRating: String) {
        self.rating.text = imDbRating
        self.starStack.rating = Double(imDbRating)
    }
    
    func display(length: String) {
        self.movieLenght.text = length
    }
    
    func display(releaseDate: String) {
        self.releaseDate.text = releaseDate
    }
    
    func display(contentRating: String) {
        self.contentRating.text = contentRating
    }
    
    func display(plot: String) {
        self.story.text = plot
    }
    
    func display(rating: String) {
        self.rating.text = rating
    }
}
