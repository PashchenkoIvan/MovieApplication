//
//  LoadTrendMovies.swift
//  MovieApplication
//
//  Created by Пащенко Иван on 09.11.2024.
//

import Foundation

extension MainViewController {
    func getMovieData () {
        if NetworkHelper.hasInternetConnection() {
            //Getting trending movies
            RequestHelper
                .request(address: .getTrendMovies, params: .getTrendMovies(.init(requestType: .get, language: "en-US"))) { (
                    responce: Result<MovieListResponce,
                    Error>
                ) in
                    switch responce {
                    
                        //In case of success
                    case .success(let result):
                    
                        RealmHelper
                            .updateDatabase(
                                dataType: DataBase.trend,
                                response: result
                            )
                    
                        self.movieList = result.results
//                        print(result.results)
                        self.trendMovieCollectionView.reloadData()
                    
                        //In case of error
                    case .failure(let error):
                        print("Error with getting trending movies")
                    
                    }
                }
        } else {
            self.movieList = RealmHelper.getData(dataType: DataBase.trend)
            self.trendMovieCollectionView.reloadData()
        }
    }
}
