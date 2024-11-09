//
//  StaticMethodsClass.swift
//  tmdb
//
//  Created by Пащенко Иван on 31.05.2024.
//

import Foundation
import UIKit
import KeychainSwift


class StorageService: NSObject {
    static func getUserData() -> ReturnUserDataStruct? {
        let keychain = KeychainSwift()
        if let userDataString = keychain.get("userData"),
           let userDataData = userDataString.data(using: .utf8) {
            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(ReturnUserDataStruct.self, from: userDataData)
                return userData
            } catch {
                print("Ошибка при декодировании данных пользователя: \(error)")
            }
        }
        return nil
    }
}
