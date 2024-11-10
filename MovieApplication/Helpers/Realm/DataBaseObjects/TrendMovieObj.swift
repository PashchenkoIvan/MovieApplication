//
//  TrendMovieObj.swift
//  tmdb
//
//  Created by Пащенко Иван on 09.07.2024.
//

import Foundation
import RealmSwift
import Realm

class TrendMovieObj: Object {
    @Persisted var adult: Bool = false
    @Persisted var backdropPath: String = String()
    @Persisted var id: Int = 0
    @Persisted var originalLanguage: String = String()
    @Persisted var originalTitle: String = String()
    @Persisted var overview: String = String()
    @Persisted var popularity: Double = 0.0
    @Persisted var posterPath: String = String()
    @Persisted var releaseDate: String = String()
    @Persisted var title: String = String()
    @Persisted var video: Bool = false
    @Persisted var voteAverage: Double = 0.0
    @Persisted var voteCount: Int = 0
}
