//
//  HomeViewController.swift
//  MoviesDB
//
//  Created by Joao Marcus Dionisio Araujo on 19/01/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView()
        loading.hidesWhenStopped = true
        loading.color = .white
        loading.translatesAutoresizingMaskIntoConstraints = false
        return loading
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Bem-vindo, João"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Categorias"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var genresCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HomeGenreCollectionViewCell.self, forCellWithReuseIdentifier: HomeGenreCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var moviesCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HomeMovieCollectionViewCell.self, forCellWithReuseIdentifier: HomeMovieCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var viewModel: HomeViewModel = HomeViewModel()
    
    private var moviesData: [Movie] = []
    
    private var genresData: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        view.backgroundColor = UIColor(hex: "#24143E")
        viewModel.delegate = self
        setup()
        loading.startAnimating()
        viewModel.fetchMovieList()
        viewModel.fetchGenreList()
    }
    
    func setup(){
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(genresCollectionView)
        view.addSubview(moviesCollectionView)
        view.addSubview(loading)
        
        NSLayoutConstraint.activate([
            
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            genresCollectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5),
            genresCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            genresCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            genresCollectionView.heightAnchor.constraint(equalToConstant: 60),
            
            moviesCollectionView.topAnchor.constraint(equalTo: genresCollectionView.bottomAnchor, constant: 10),
            moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            moviesCollectionView.heightAnchor.constraint(equalToConstant: view.bounds.width - 60),
            
        ])
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(collectionView == self.genresCollectionView){
            return 1
        } else if (collectionView == self.moviesCollectionView) {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.genresCollectionView){
            return genresData.count
        } else if (collectionView == self.moviesCollectionView) {
            return moviesData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == self.genresCollectionView){
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGenreCollectionViewCell.identifier, for: indexPath) as? HomeGenreCollectionViewCell else {
                
                return UICollectionViewCell()
            }
            
            cell.setup()
            cell.setupData(genre: genresData[indexPath.row])
            
            return cell
        } else if (collectionView == self.moviesCollectionView) {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMovieCollectionViewCell.identifier, for: indexPath) as? HomeMovieCollectionViewCell else {
                
                return UICollectionViewCell()
            }
            
            cell.setup()
            let movie = moviesData[indexPath.item]
            cell.setupData(movie: movie)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == self.genresCollectionView){
            return CGSize(width: 140, height: 60)
        } else if (collectionView == self.moviesCollectionView) {
            return CGSize(width: (view.bounds.width / 2), height: view.bounds.width / 1.5)
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == self.genresCollectionView){
            moviesData = []
            moviesCollectionView.reloadData()
            viewModel.currentPage = 1
            UIView.animate(withDuration: 0.5, animations: {
                 self.moviesCollectionView.contentOffset.x = 0
            })
            viewModel.fetchMovieList(genre: genresData[indexPath.row].id)
        }else{
            
            guard let cell = moviesCollectionView.cellForItem(at: indexPath) as? HomeMovieCollectionViewCell else {
                return
            }
            
            let vc = MovieDetailsViewController()
            vc.image = cell.backgroundImage.image
            vc.movieId = moviesData[indexPath.row].id
            vc.movieTitle = moviesData[indexPath.row].title
            vc.movieDescription = moviesData[indexPath.row].overview
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == moviesData.count - 1 ) {
            if viewModel.currentPage < viewModel.totalPages {
                viewModel.currentPage += 1
                self.loading.startAnimating()
                if(viewModel.selectedGenre != nil){
                    viewModel.fetchMovieList(genre: viewModel.selectedGenre ?? 0)
                    return
                }
                viewModel.fetchMovieList()
            }
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didGetData(genresData: [Genre]) {
        self.genresData = genresData
        self.genresCollectionView.reloadData()
    }
    
    
    func didGetData(moviesData: MovieListResponse) {
        self.moviesData += moviesData.results
        self.moviesCollectionView.reloadData()
        self.loading.stopAnimating()
        
    }
    
    func didError(error: String) {
        self.loading.stopAnimating()
        self.moviesCollectionView.reloadData()
        print(error)
    }
}
