//
//  ViewController.swift
//  MovieApplication
//
//  Created by Пащенко Иван on 07.11.2024.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieTextLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setImage()
        self.setMovieTitle()
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        self.buttonPress()
    }
    
}


