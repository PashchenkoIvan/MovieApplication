//
//  MainViewController.swift
//  MovieApplication
//
//  Created by Пащенко Иван on 09.11.2024.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var trendMovieCollectionView: UICollectionView!
    
    var movieList: [Movie] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getMovieData()
    }
    
}
