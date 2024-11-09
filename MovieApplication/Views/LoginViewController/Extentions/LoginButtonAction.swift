//
//  ButtonAction.swift
//  MovieApplication
//
//  Created by Пащенко Иван on 09.11.2024.
//

import KeychainSwift

extension LoginViewController {
    func buttonPress () {
        if usernameTextField.text?.count == 0 && passwordTextField.text?.count == 0 {
            UIViewController.showAlert(title: "Incorect data", message: "Please write an username and a password")
            return
        } else if passwordTextField.text?.count == 0 {
            UIViewController.showAlert(title: "Incorect password", message: "Please write a password")
            return
        } else if usernameTextField.text?.count == 0 {
            UIViewController.showAlert(title: "Incorect username", message: "Please write an username")
            return
        }
        
        guard let userName = usernameTextField.text else {
            print("Error with username")
            return
        }
        
        guard let password = passwordTextField.text else {
            print("Error with password")
            return
        }
        
        if NetworkHelper.hasInternetConnection() {
            LoginProccess.loginUser(username: userName, password: password) { responce in
                switch responce {
                case .success(let result):
                    DispatchQueue.main.async {
                        let encoder = JSONEncoder()
                        if let encodedData = try? encoder.encode(result) {
                            
                            let keychain = KeychainSwift()
                            keychain.set(encodedData, forKey: "userData")
                            
                            let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
                            
                            tabBarController.modalPresentationStyle = .fullScreen
                            self.present(tabBarController, animated: true, completion: nil)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            UIViewController.showAlert(title: "No Internet Connection", message: "You don't have internet connection.")
        }
    }
}
