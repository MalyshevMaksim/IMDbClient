//
//  DetailTopMovieViewController.swift
//  IMDbClient
//
//  Created by Малышев Максим Алексеевич on 9/2/20.
//  Copyright © 2020 Малышев Максим Алексеевич. All rights reserved.
//

import Foundation
import UIKit

class DetailMovieViewController: UIViewController, ViewControllerProtocol {
    var presenter: DetailMoviePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.45
        view.addSubview(poster)
        return view
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textColor = UIColor(red: 24/255, green: 52/255, blue: 77/255, alpha: 1)
        return label
    }()
    
    lazy var story: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor(red: 110/255, green: 130/255, blue: 144/255, alpha: 1)
        label.numberOfLines = .max
        return label
    }()
    
    lazy var starStack: RatingStackView = {
        let starStack = RatingStackView(with: 5.0)
        starStack.translatesAutoresizingMaskIntoConstraints = false
        return starStack
    }()
    
    private func setupSubviews() {
        view.addSubview(name)
        view.addSubview(rating)
        view.addSubview(stackView)
        view.addSubview(storyline)
        view.addSubview(story)
        view.addSubview(starStack)
        view.addSubview(shadowView)
    }
    
    private func setupView() {
        setupSubviews()
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            shadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shadowView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.5),
            shadowView.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.66),
            poster.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.5),
            poster.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.66),
            
            name.topAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: 25),
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            rating.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 15),
            rating.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            starStack.topAnchor.constraint(equalTo: rating.bottomAnchor, constant: 5),
            starStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starStack.widthAnchor.constraint(equalToConstant: 100),
            starStack.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.topAnchor.constraint(equalTo: starStack.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            storyline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            storyline.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            
            story.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            story.topAnchor.constraint(equalTo: storyline.bottomAnchor, constant: 10),
            story.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

extension DetailMovieViewController {
    func success() {
        let lowResolutionPoster = "https://imdb-api.com/images/600x800/"
        let lowResolutionPosterEndpoint = (presenter.detailMovie.image as NSString).lastPathComponent
        
        poster.downloadImage(from: lowResolutionPoster + lowResolutionPosterEndpoint)
        name.text = presenter.detailMovie.title
        rating.text = presenter.detailMovie.imDbRating
        movieLenght.text = "⏱ \(presenter.detailMovie.runtimeStr)"
        releaseDate.text = "🗓 \(presenter.detailMovie.year)"
        contentRating.text = "🔞 \(presenter.detailMovie.contentRating)"
        story.text = presenter.detailMovie.plot
    }
    
    func failure(error: Error) {
        print(error)
    }
}
