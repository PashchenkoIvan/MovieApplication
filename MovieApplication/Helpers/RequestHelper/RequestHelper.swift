//
//  RequestHelper.swift
//  TheMovieApp
//
//  Created by Пащенко Иван on 18.07.2024.
//

import Foundation
import Alamofire

enum DefaultValues {
    static var apiKey: String? {
        return ProcessInfo.processInfo.environment["api_key"]
    }
    static var apiRequest: String? {
        return ProcessInfo.processInfo.environment["session_key"]
    }
    static let defaultUrl: String = "https://api.themoviedb.org/3/"
    static let defaultImageUrl: String = "https://image.tmdb.org/t/p/original"
}

//Data type for selecting the request address
enum Endpoints: String {
    case genresList = "genre/movie/list"
    case movieList = "discover/movie"
    case getRequestToken = "authentication/token/new"
    case createRequestToken = "authentication/token/validate_with_login"
    case createSessionId = "authentication/session/new"
    case getUserInfo = "account"
    case getFavoriteMovies = "account/"
    case getTrendMovies = "trending/movie/day"
    case searchMovie = "search/movie"
    case deleteSession = "authentication/session"
}

//Data type for selecting the type of request input parameters
enum EndpointParams {
    case genresListParam(getGenresListParams)
    case getMovieParam(getMovieParams)
    case getRequestTokenParam(getRequestTokenParams)
    case createRequestTokenParam(createRequestTokenParams)
    case createSessionIdParam(createSessionIdParams)
    case getUserInfoParam(getUserInfoParams)
    case getFavoriteMoviesParam(getFavoritesParams)
    case getTrendMovies(getMoviesTrendparams)
    case addRemoveFavoriteMovie(addRemoveMovieParams)
    case searchMovie(searchMovieParams)
    case deleteSession(deleteSession)
}



class RequestHelper {
    static func request<T: Codable>(address: Endpoints, params: EndpointParams, rawBody: Parameters? = nil, completion: @escaping (Result<T, Error>) -> ()) {
        var url: String
        var method: HTTPMethod
        
        //Selecting the required request
        switch params {
            
        case .addRemoveFavoriteMovie(let param):
            url = "\(DefaultValues.defaultUrl)\(address.rawValue)\(param.accountId)/favorite?session_id=\(param.sessionId)"
            method = param.requestType
            
        case .genresListParam(let param):
            url = "\(DefaultValues.defaultUrl)\(address.rawValue)?language=\(param.language)"
            method = param.requestType
            
        case .getMovieParam(let param):
            url = "\(DefaultValues.defaultUrl)\(address.rawValue)"
            method = param.requestType
            
        case .getRequestTokenParam(let param):
            url = "\(DefaultValues.defaultUrl)\(address.rawValue)"
            method = param.requestType
            
        case .createRequestTokenParam(let param):
            url = "\(DefaultValues.defaultUrl)\(address.rawValue)?username=\(param.username)&password=\(param.password)&request_token=\(param.requestToken)"
            method = param.requestType
            
        case .createSessionIdParam(let param):
            url = "\(DefaultValues.defaultUrl)\(address.rawValue)?request_token=\(param.requestToken)"
            method = param.requestType
            
        case .getUserInfoParam(let param):
            url = "\(DefaultValues.defaultUrl)\(address.rawValue)?session_id=\(param.sessionId)"
            method = param.requestType
            
        case .getFavoriteMoviesParam(let param):
            url = "\(DefaultValues.defaultUrl)\(address.rawValue)/\(param.accountId)/favorite/movies?language=\(param.language)&page=\(param.page)&sort_by=\(param.sortBy)&session_id=\(param.sessionId)"
            method = param.requestType
            
        case .getTrendMovies(let param):
            url = "\(DefaultValues.defaultUrl)\(address.rawValue)?language=\(param.language)"
            method = param.requestType
            
        case .searchMovie(let param):
            url = "\(DefaultValues.defaultUrl)\(address.rawValue)?query=\(param.query)"
            method = param.requestType
            
        case .deleteSession(let param):
            url = "\(DefaultValues.defaultUrl)\(address.rawValue)"
            method = param.requestType
        }
        
        
        //
        if rawBody != nil {
            AF.request(url, method: method, parameters: rawBody, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer \(DefaultValues.apiRequest! )"])
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        guard let json = value as? [String: Any] else {
                            print("Invalid data format")
                            return
                        }
                        
                        let jsonData = try! JSONSerialization.data(withJSONObject: json)
                        let decoder = JSONDecoder()
                        
                        do {
                            let resultData = try decoder.decode(T.self, from: jsonData)
                            completion(.success(resultData))
                        } catch {
                            print("Decode error: \(error)")
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
        } else {
            AF.request(url, method: method, encoding: JSONEncoding.default, headers: ["Authorization": "Bearer \(DefaultValues.apiRequest!)"])
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        guard let json = value as? [String: Any] else {
                            print("Invalid data format")
                            return
                        }
                        
                        let jsonData = try! JSONSerialization.data(withJSONObject: json)
                        let decoder = JSONDecoder()
                        
                        do {
                            let resultData = try decoder.decode(T.self, from: jsonData)
                            completion(.success(resultData))
                        } catch {
                            print("Decode error: \(error)")
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
        }
    }
}
