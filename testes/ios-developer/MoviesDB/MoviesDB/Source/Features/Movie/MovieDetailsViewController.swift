//
//  MovieDetailsViewController.swift
//  MoviesDB
//
//  Created by Joao Marcus Dionisio Araujo on 19/01/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private lazy var headerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var backButton: RoundedButton = {
        let button = RoundedButton(color: .white, type: .outlined, icon: UIImage(systemName: "arrowshape.turn.up.backward.fill") ?? UIImage())
        button.button.addTarget(self, action: #selector(didBackPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "highlight-image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var mainDetailsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#24143E")
        
        return view
    }()
    
    private lazy var mainDetailsTitle: UILabel = {
        let label = UILabel()
        label.text = "Titulo"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var mainDetailsDescription: UILabel = {
        let label = UILabel()
        label.text = "Super evento em Maceió"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var mainDetailsDirector: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var mainDetailsCast: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //Public Properties
    
    var image: UIImage? {
        didSet {
            self.headerImage.image = image
        }
    }
    
    var movieId: Int? {
        didSet {
            self.viewModel.delegate = self
            self.viewModel.fetchMovieDetails(movieId: movieId ?? 0)
        }
    }
    
    var movieTitle: String? {
        didSet {
            mainDetailsTitle.text = movieTitle
        }
    }
    
    var movieDescription: String? {
        didSet {
            mainDetailsDescription.text = movieDescription
        }
    }
    
    var viewModel: MovieDetailsViewModel = MovieDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#24143E")
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func didBackPressed(){
        dismiss(animated: true, completion: nil)
    }
    
    func setup(){
        
        view.addSubview(headerContainer)
        headerContainer.addSubview(headerImage)
        headerContainer.addSubview(backButton)
        view.addSubview(mainDetailsContainer)
        mainDetailsContainer.addSubview(mainDetailsTitle)
        mainDetailsContainer.addSubview(mainDetailsDirector)
        mainDetailsContainer.addSubview(mainDetailsCast)
        mainDetailsContainer.addSubview(mainDetailsDescription)
        
        NSLayoutConstraint.activate([
            
            headerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            headerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            headerContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            headerContainer.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 25),
            
            headerImage.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 0),
            headerImage.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: 0),
            headerImage.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 0),
            headerImage.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: 0),
            
            backButton.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 30),
            backButton.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 35),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            
            mainDetailsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainDetailsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainDetailsContainer.heightAnchor.constraint(equalToConstant: 100),
            mainDetailsContainer.topAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: 0),
            mainDetailsContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainDetailsTitle.leadingAnchor.constraint(equalTo: mainDetailsContainer.leadingAnchor, constant: 15),
            mainDetailsTitle.trailingAnchor.constraint(equalTo: mainDetailsContainer.trailingAnchor, constant: -15),
            mainDetailsTitle.topAnchor.constraint(equalTo: mainDetailsContainer.topAnchor, constant: 15),
            
            
            mainDetailsDirector.leadingAnchor.constraint(equalTo: mainDetailsContainer.leadingAnchor, constant: 25),
            mainDetailsDirector.trailingAnchor.constraint(equalTo: mainDetailsContainer.centerXAnchor, constant: 0),
            mainDetailsDirector.topAnchor.constraint(equalTo: mainDetailsTitle.bottomAnchor, constant: 8),
            
            mainDetailsCast.leadingAnchor.constraint(equalTo: mainDetailsContainer.centerXAnchor, constant: 15),
            mainDetailsCast.trailingAnchor.constraint(equalTo: mainDetailsContainer.trailingAnchor, constant: -25),
            mainDetailsCast.topAnchor.constraint(equalTo: mainDetailsTitle.bottomAnchor, constant: 8),
            
            
            mainDetailsDescription.leadingAnchor.constraint(equalTo: mainDetailsContainer.leadingAnchor, constant: 15),
            mainDetailsDescription.trailingAnchor.constraint(equalTo: mainDetailsContainer.trailingAnchor, constant: -15),
            mainDetailsDescription.topAnchor.constraint(equalTo: mainDetailsCast.bottomAnchor, constant: 25),
            
        ])
    }
    
}
extension MovieDetailsViewController: MovieDetailsViewModelDelegate {
    func didGetData(movieDetails: MovieDetails) {
        //Getting director
        for worker in movieDetails.credits.crew {
            if worker.job.lowercased() == "director" {
                mainDetailsDirector.text = "Director: \(worker.name)"
            }
        }

        var actorNames = ""
        if(movieDetails.credits.cast.count >= 3){
            for item in 0..<3 {
                actorNames += movieDetails.credits.cast[item].name + ", "
            }
        } else {
            for item in 0..<movieDetails.credits.cast.count {
                actorNames += movieDetails.credits.cast[item].name + ", "
            }
        }
        actorNames.removeLast(2)
        mainDetailsCast.text = "Cast: \(actorNames)"
        
    }
    
    func didError(error: String) {
        
    }
    
    
}
