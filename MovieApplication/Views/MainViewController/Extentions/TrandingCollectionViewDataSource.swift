//
//  TrandingCollectionViewDataSource.swift
//  MovieApplication
//
//  Created by Пащенко Иван on 09.11.2024.
//

import UIKit
import Kingfisher

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath) as! TrendingCollectionViewCell
        
        print(movieList[indexPath.row])
        
        let imageUrl = URL(string: "\(DefaultValues.defaultImageUrl)\(self.movieList[indexPath.row].backdropPath ?? "")")
        
        cell.trendMovieImageView.kf.setImage(with: imageUrl)
        
        cell.trendMovieTitle.text = self.movieList[indexPath.row].title
        cell.trendMovieDate.text = self.movieList[indexPath.row].releaseDate
        cell.trendMovieDescription.text = self.movieList[indexPath.row].overview
        cell.trendMovieVoteCount.text = "\(self.movieList[indexPath.row].voteCount ?? 0)"
        cell.trendMovieVoteAverage.text = "\(self.movieList[indexPath.row].voteAverage ?? 0)"
        
        return cell
    }
}
