//
//  TrendingCollectionViewSkeleton.swift
//  MovieApplication
//
//  Created by Пащенко Иван on 10.11.2024.
//

import Foundation
import SkeletonView

extension MainViewController {
    func setupTrendingCollectiomaViewSkeleton() {
        self.trendMovieCollectionView.isSkeletonable = true
        self.trendMovieCollectionView.showSkeleton(usingColor: .gray, transition: .crossDissolve(0.25))
    }
}
