//
//  HomeMovieCollectionViewCell.swift
//  MoviesDB
//
//  Created by Joao Marcus Dionisio Araujo on 19/01/22.
//

import UIKit

class HomeMovieCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "HomeMovieCollectionViewCell"
    
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "missing-image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var favoriteButton: RoundedButton = {
        let button = RoundedButton(color: .orange, type: .primary, icon: UIImage(systemName: "suit.heart") ?? UIImage())

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var infoContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var infoTitle: UILabel = {
        let label = UILabel()
        label.text = "Super evento em Maceió"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var infoSubtitle: UILabel = {
        let label = UILabel()
        label.text = "Avg: 0 Votes: 3403"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var releaseDate: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    func setupData(movie: Movie){
        self.infoTitle.text = movie.title
        self.releaseDate.text = movie.releaseDate
        self.infoSubtitle.text = "Avg: \(movie.voteAverage) Votes: \(movie.voteCount)"
        self.backgroundImage.downloaded(from: "\(MovieAPI.imageURL)/\(MovieAPI.ImageSize.w500.rawValue)/\(movie.posterPath ?? "")")
    }
    
    func setup(){
        
        contentView.addSubview(container)
        container.addSubview(backgroundImage)
        container.addSubview(infoContainer)
        infoContainer.addSubview(infoTitle)
        infoContainer.addSubview(infoSubtitle)
        infoContainer.addSubview(releaseDate)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            backgroundImage.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            backgroundImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
            
            infoContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            infoContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            infoContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
            infoContainer.heightAnchor.constraint(equalToConstant: 90),
            
            infoTitle.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 15),
            infoTitle.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -15),
            infoTitle.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 10),
            
            infoSubtitle.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 15),
            infoSubtitle.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -15),
            infoSubtitle.topAnchor.constraint(equalTo: infoTitle.bottomAnchor, constant: 5),
            
            releaseDate.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 15),
            releaseDate.trailingAnchor.constraint(equalTo: infoContainer.trailingAnchor, constant: -15),
            releaseDate.topAnchor.constraint(equalTo: infoSubtitle.bottomAnchor, constant: 10),
            
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.infoTitle.text = ""
        self.releaseDate.text = ""
        self.backgroundImage.image = UIImage(named: "missing-image")

    }
}

