//
//  Router.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import Foundation

enum Router {
    case register(parameters: RegisterQuery)
}

extension Router: TargetType {
    var scheme: String {
        return "http"
    }
    
    var host: String {
        return APIKey.baseURL
    }
    
    var header: [String : String]? {
        switch self {
        case .register:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .register:
            return .post
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: APIKey.baseURL)!
    }
    
    var testURL: URL {
        return URL(string: APIKey.testURL)!
    }
    
    var path: String {
        switch self {
        case .register:
            return "/register"
        }
    }
    
    var port: Int {
        return 8080
    }
    
    
    var body: Data? {
        switch self {
        case .register(let parameters):
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let parameters = ["email": parameters.email, "password": parameters.password, "name": parameters.name]
            return try? encoder.encode(parameters)
        }
    }
    
    //test용
    func buildRequest() -> URLRequest {
        let url = testURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = header
        request.httpBody = body
        print("TestHeader", request.allHTTPHeaderFields)
        return request
    }
}
