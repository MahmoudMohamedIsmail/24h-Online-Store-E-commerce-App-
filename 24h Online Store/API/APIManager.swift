//
//  APIManager.swift
//  24h Online Store
//
//  Created by macboock pro on 10/3/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import Foundation

class APIManager {
    
    static let apiKey = "YOUR_TMDB_API_KEY"
    
    struct Auth {
        //static var accountId = 0
        static var requestToken = ""
        // static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://student.valuxapps.com/api/"
        // static let apiKeyParam = ""
        
        
        case login
        case logout
        case signUp
        case webAuth
        
        var stringValue: String {
            switch self {
                
            case .login:
                return Endpoints.base + "login"
                
            case .logout:
                return Endpoints.base + "/authentication/session"
            case .webAuth:
                return "https://www.themoviedb.org/authenticate/\(Auth.requestToken)?redirect_to=themoviemanager:authenticate"
            case .signUp:
                return Endpoints.base + "register"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                completion(responseObject, nil)
            } catch {
                completion(nil, error)
                
            }
        }
        task.resume()
        
        return task
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("ar", forHTTPHeaderField: "lang")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                completion(responseObject, nil)
            } catch {
                
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    
    class func getRequestToken(completion: @escaping (Bool, Error?) -> Void) {
        //        taskForGETRequest(url: Endpoints.getRequestToken.url, responseType: RequestTokenResponse.self) { response, error in
        //            if let response = response {
        //                Auth.requestToken = response.requestToken
        //                completion(true, nil)
        //            } else {
        //                completion(false, error)
        //            }
        //        }
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        
//        let body = LoginRequest(username: username, password: password)
//        
//        taskForPOSTRequest(url: Endpoints.login.url, responseType: LoginSuccessModel.self, body: body) { response, error in
//            
//            guard let response = response else {
//                completion(false, error)
//                return
//            }
//            
//            if let data = response.data {
//                
//                Helper.saveApiToken(token: response.data.token)
//                Auth.requestToken = response.data.token
//                completion(true, nil)
//            } else {
//                completion(false, error)
//            }
//        }
    }
    
    class func createSessionId(completion: @escaping (Bool, Error?) -> Void) {
        //        let body = PostSession(requestToken: Auth.requestToken)
        //        taskForPOSTRequest(url: Endpoints.createSessionId.url, responseType: SessionResponse.self, body: body) { response, error in
        //            if let response = response {
        //                Auth.sessionId = response.sessionId
        //                completion(true, nil)
        //            } else {
        //                completion(false, nil)
        //            }
        //        }
    }
    
    class func logout(completion: @escaping () -> Void) {
        //        var request = URLRequest(url: Endpoints.logout.url)
        //        request.httpMethod = "DELETE"
        //        let body = LogoutRequest(sessionId: Auth.sessionId)
        //        request.httpBody = try! JSONEncoder().encode(body)
        //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //            Auth.requestToken = ""
        //            Auth.sessionId = ""
        //            completion()
        //        }
        //        task.resume()
    }
    
    //    class func search(query: String, completion: @escaping ([Movie], Error?) -> Void) -> URLSessionDataTask {
    //        let task = taskForGETRequest(url: Endpoints.search(query).url, responseType: MovieResults.self) { response, error in
    //            if let response = response {
    //                completion(response.results, nil)
    //            } else {
    //                completion([], error)
    //            }
    //        }
    //        return task
}


