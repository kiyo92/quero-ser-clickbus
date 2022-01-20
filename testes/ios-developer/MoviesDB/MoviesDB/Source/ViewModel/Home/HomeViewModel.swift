//
//  HomeViewModel.swift
//  MoviesDB
//
//  Created by Joao Marcus Dionisio Araujo on 19/01/22.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didGetData(moviesData: MovieListResponse)
    func didGetData(genresData: [Genre])
    func didError(error: String)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    var currentPage = 1
    var totalPages = 1
    var selectedGenre: Int? = nil
    
    func fetchMovieList(){
        MovieListWorker().fetchMovieList(
            section: .popular, page: currentPage,
            sucess: { response in
                guard let moviesData = response else { return }
                self.totalPages = moviesData.totalPages
                self.delegate?.didGetData(moviesData: moviesData)
            },
            failure: { error in
                print(error)
                self.delegate?.didError(error: "Ocorreu um erro!")
            })
    }
    
    func fetchMovieList(genre: Int){
        selectedGenre = genre
        MovieListWorker().fetchMovieList(
            genreId: selectedGenre ?? 0, page: currentPage,
            sucess: { response in
                guard let moviesData = response else { return }
                self.totalPages = moviesData.totalPages
                self.delegate?.didGetData(moviesData: moviesData)
            },
            failure: { error in
                print(error)
                self.delegate?.didError(error: "Ocorreu um erro!")
            })
    }
    
    func fetchGenreList(){
        GenreListWorker().fetchGenreList(
            sucess: { response in
                guard let genres = response?.genres else { return }
                self.delegate?.didGetData(genresData: genres)
            },
            failure: { error in
                print(error)
                self.delegate?.didError(error: "Ocorreu um erro!")
            })
    }
}
