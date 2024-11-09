//
//  ImageSettings.swift
//  MovieApplication
//
//  Created by Пащенко Иван on 09.11.2024.
//

import UIKit
import Kingfisher

extension LoginViewController {
    func setImage() {
        let gradient = CAGradientLayer()
        
        gradient.frame = imageView.bounds
        gradient.colors = [UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 0.1, 0.5, 0.9, 1.0]
        
        imageView.layer.insertSublayer(gradient, at: 0)
        
        let url = URL(string: "https://i.pinimg.com/564x/20/a4/23/20a4239750efa6d888960faafd1e8708.jpg")
        imageView.kf.setImage(with: url)
    }
}
