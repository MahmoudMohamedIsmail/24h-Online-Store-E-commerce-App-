//
//  APIManager.swift
//  24h Online Store
//
//  Created by macboock pro on 10/3/20.
//  Copyright © 2020 macboock pro. All rights reserved.
//

import Foundation

class APIManager {
    
    struct Auth {
        static var requestToken = ""
    }
    
    enum Endpoints {
        static let base = "https://student.valuxapps.com/api/"
        
        case login
        case logout
        case signUp
        case home
        
        var stringValue: String {
            switch self {
            case .login:
                return Endpoints.base + "login"
            case .logout:
                return Endpoints.base + "/authentication/session"
            case .signUp:
                return Endpoints.base + "register"
            case .home:
                 return Endpoints.base + "home"
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
}


