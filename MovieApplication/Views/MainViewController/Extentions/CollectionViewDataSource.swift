//
//  TrandingCollectionViewDataSource.swift
//  MovieApplication
//
//  Created by Пащенко Иван on 09.11.2024.
//

import UIKit
import Kingfisher
import SkeletonView

extension MainViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return "TrendingCollectionViewCell"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.trendMovieCollectionView {
            //MARK: Setup trending cells quantity
            return self.movieList.count
        } else if collectionView == self.genresCollectionView {
            //MARK: Setup genre cells quantity
            return genresData.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.trendMovieCollectionView {
            //MARK: Setup trendMovie cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath) as! TrendingCollectionViewCell
            
            let imageUrl = URL(string: "\(DefaultValues.defaultImageUrl)\(self.movieList[indexPath.row].backdropPath ?? "")")
            
            cell.trendMovieImageView.kf.setImage(with: imageUrl)
            cell.trendMovieTitle.text = self.movieList[indexPath.row].title
            cell.trendMovieDate.text = self.movieList[indexPath.row].releaseDate
            cell.trendMovieDescription.text = self.movieList[indexPath.row].overview
            cell.trendMovieVoteCount.text = "\(self.movieList[indexPath.row].voteCount ?? 0)"
            cell.trendMovieVoteAverage.text = "\(self.movieList[indexPath.row].voteAverage ?? 0)"
            
            return cell
        } else if collectionView == self.genresCollectionView {
            //MARK: Setup genre cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCollectionViewCell", for: indexPath) as! GenresCollectionViewCell

            cell.genreCellTextLabel.text = genresData[indexPath.row].name

            let tintColor = genresData[indexPath.row].backgroundColor
            let originalImage = genresData[indexPath.row].image
            cell.genresCellImageView.image = originalImage.applyTint(to: originalImage, with: tintColor)

            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
