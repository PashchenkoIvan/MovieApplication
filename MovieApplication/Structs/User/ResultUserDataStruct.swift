//
//  ResultUserDataStruct.swift
//  TheMovieApp
//
//  Created by Пащенко Иван on 18.07.2024.
//

import Foundation

public struct ReturnUserDataStruct: Encodable, Decodable {
    let sessionId: String
    let userData: User
}
