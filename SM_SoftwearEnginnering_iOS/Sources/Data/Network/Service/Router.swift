//
//  Router.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import Foundation

enum Router {
    case register(parameters: RegisterQuery)
    case createFolder(parameters: FolderPostQuery)
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
        case .register, .createFolder:
            return ["accept" : "application/json" , "Content-Type": "application/json"]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .register, .createFolder:
            return .post
        }
    }
    
    var parameters: String? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: APIKey.baseURL)!
    }
    
    var path: String {
        switch self {
        case .register:
            return "/register"
        case .createFolder:
            return "/folder"
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
            
        case .createFolder(let parameters):
            let folderPostDto = FolderPostDto(folderTitle: parameters.folderTitle, memberId: parameters.memberId, color: parameters.color)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(folderPostDto)
        }
    }
}
