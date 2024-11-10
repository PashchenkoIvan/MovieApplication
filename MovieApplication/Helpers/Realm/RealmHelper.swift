//
//  RealmHelper.swift
//  tmdb
//
//  Created by Пащенко Иван on 09.07.2024.
//

import Foundation
import RealmSwift

enum DataBase {
    case favorite
    case trend
}

class RealmHelper {
    static func updateDatabase(dataType: DataBase, response: MovieListResponce) {
        let realm = try! Realm()
        
        response.results.forEach { movie in
            switch dataType {
                
            case .favorite:
                saveMovie(movie: movie, realm: realm, objectType: FavoriteMovieObj.self)
                removeExtraMovie(response: response, realm: realm, objectType: FavoriteMovieObj.self)
            case .trend:
                saveMovie(movie: movie, realm: realm, objectType: TrendMovieObj.self)
                removeExtraMovie(response: response, realm: realm, objectType: TrendMovieObj.self)
            }
        }
    }
    
    static func getData(dataType: DataBase) -> [Movie] {
        var result: [Movie] = []
        let realm = try! Realm()
        
        switch dataType {
            
        case .favorite:
            let movies = realm.objects(FavoriteMovieObj.self)
            
            movies.forEach { movie in
                result.append(Movie(adult: movie.adult, backdropPath: movie.backdropPath, genreIDS: [], id: movie.id, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount))
            }
            
        case .trend:
            let movies = realm.objects(TrendMovieObj.self)
            
            movies.forEach { movie in
                result.append(Movie(adult: movie.adult, backdropPath: movie.backdropPath, genreIDS: [], id: movie.id, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount))
            }
        }
        
        return result
    }
    
    private static func removeExtraMovie<T: Object>(response: MovieListResponce, realm: Realm, objectType: T.Type) where T: MovieProtocol {
        let savedMovies = realm.objects(objectType)
        
        savedMovies.forEach { savedMovie in
            if !response.results.contains(where: { $0.id == savedMovie.id }) {
                try! realm.write {
                    realm.delete(savedMovie)
                }
            }
        }
    }

    
    private static func saveMovie<T: Object>(movie: Movie, realm: Realm, objectType: T.Type) where T: MovieProtocol {
        let savedMovies = realm.objects(objectType)
        
        if !savedMovies.contains(where: { $0.id == movie.id }) {
            let movieRealm = objectType.init()
            movieRealm.setup(with: movie)
            
            try! realm.write {
                realm.add(movieRealm)
            }
        }
    }
}

protocol MovieProtocol {
    var id: Int { get set }
    func setup(with movie: Movie)
}

extension FavoriteMovieObj: MovieProtocol {
    func setup(with movie: Movie) {
        self.adult = movie.adult ?? false
        self.backdropPath = movie.backdropPath ?? ""
        self.id = movie.id ?? 0
        self.originalLanguage = movie.originalLanguage ?? ""
        self.originalTitle = movie.originalTitle ?? ""
        self.overview = movie.overview ?? ""
        self.popularity = movie.popularity ?? 0.0
        self.posterPath = movie.posterPath ?? ""
        self.releaseDate = movie.releaseDate ?? ""
        self.title = movie.title ?? ""
        self.video = movie.video ?? false
        self.voteAverage = movie.voteAverage ?? 0.0
        self.voteCount = movie.voteCount ?? 0
    }
}

extension TrendMovieObj: MovieProtocol {
    func setup(with movie: Movie) {
        self.adult = movie.adult ?? false
        self.backdropPath = movie.backdropPath ?? ""
        self.id = movie.id ?? 0
        self.originalLanguage = movie.originalLanguage ?? ""
        self.originalTitle = movie.originalTitle ?? ""
        self.overview = movie.overview ?? ""
        self.popularity = movie.popularity ?? 0.0
        self.posterPath = movie.posterPath ?? ""
        self.releaseDate = movie.releaseDate ?? ""
        self.title = movie.title ?? ""
        self.video = movie.video ?? false
        self.voteAverage = movie.voteAverage ?? 0.0
        self.voteCount = movie.voteCount ?? 0
    }
}
