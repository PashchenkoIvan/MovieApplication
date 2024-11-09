//
//  TrendingCollectionViewCell.swift
//  MovieApplication
//
//  Created by Пащенко Иван on 09.11.2024.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var trendMovieImageView: UIImageView!
    @IBOutlet weak var trendMovieTitle: UILabel!
    @IBOutlet weak var trendMovieVoteAverage: UILabel!
    @IBOutlet weak var trendMovieVoteCount: UILabel!
    @IBOutlet weak var trendMovieDate: UILabel!
    @IBOutlet weak var trendMovieDescription: UILabel!
}
