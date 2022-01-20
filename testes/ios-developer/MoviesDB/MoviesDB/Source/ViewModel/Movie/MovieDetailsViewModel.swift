//
//  MovieViewModel.swift
//  MoviesDB
//
//  Created by Joao Marcus Dionisio Araujo on 19/01/22.
//

import Foundation

protocol MovieDetailsViewModelDelegate: AnyObject {
    func didGetData(movieDetails: MovieDetails)
    func didError(error: String)
}

class MovieDetailsViewModel {
    
    weak var delegate: MovieDetailsViewModelDelegate?
    
    func fetchMovieDetails(movieId: Int) {
        MovieDetailsWorker().fetchMovieDetails(
            of: movieId,
            sucess: { details in
                guard let details = details else { return }
                self.delegate?.didGetData(movieDetails: details)
            },
            failure: { error in
                print(error!)
            })
    }
}
