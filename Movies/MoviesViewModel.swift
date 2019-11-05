//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Vaayoo on 02/07/19.
//  Copyright © 2019 Vaayoo. All rights reserved.
//

import UIKit
import Alamofire
class MoviesViewModel: NSObject {
    var movies: [Welcome]!
    var moviesClient = MoviesAPIClient()
    func fetchMovie(endPoint: String, completion: @escaping () -> ()){
        moviesClient.fetchMovies(url: endPoint) { [weak self](welcomeJeans: [Welcome]) in
            self?.movies = welcomeJeans
            completion()
        }
    }
    func numberOfRowsInSection(rows: Int) -> Int {
        return self.movies?.count ?? 0
    }
    func titleForRowAtIndexPath(indexPath: IndexPath) -> String{
        if let entry = self.movies?[indexPath.row]{
            return entry.title
        }
        return ""
    }
}
