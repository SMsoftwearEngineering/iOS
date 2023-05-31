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
    case createTodo(parameters: TodoPostQuery)
    case login(parameters: LoginQuery)
    case deleteTodo(parameters: DeleteTodoQuery)
    case getFolderList
    case getTest(parameters: TestQuery)
}

extension Router: TargetType {
    var scheme: String {
        return "http"
    }
    
    var host: String {
        return APIKey.baseURL
    }
    
    var header: [String : String]? {
        var headers = ["accept" : "application/json", "Content-Type": "application/json"]
        
        switch self {
        case .createTodo, .deleteTodo, .createFolder, .getFolderList, .getTest:
            guard let token = UserDefaults.standard.string(forKey: "token") else { return headers }
            let header = ["accept" : "application/json", "Authorization" : "Bearer \(token)", "Content-Type": "application/json"]
            print(header, "header")
            return header
        case .register, .login:
            return headers
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .register, .createFolder, .createTodo, .login:
            return .post
        case .deleteTodo:
            return .delete
        case .getFolderList, .getTest:
            return .get
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
            return "/auth/register"
        case .createFolder:
            return "/folder"
        case .createTodo, .deleteTodo:
            return "/todo"
        case .login:
            return "/auth/login"
        case .getFolderList:
            return "/folder/list"
        case .getTest:
            return "/"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getFolderList:
            
            let id = UserDefaults.standard.string(forKey: "id")
            let userId = UserDefaults.standard.integer(forKey: "memberId")
            return [URLQueryItem(name: "userId", value: String(userId)), URLQueryItem(name: "sortBy", value: id), URLQueryItem(name: "pageSize", value: "1"), URLQueryItem(name: "pageNo", value: "1")]
            
        case .getTest(let parameters):
            return [URLQueryItem(name: "memberId", value: String(parameters.memberId))]
        default:
            return nil
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
            print(folderPostDto, "check")
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(folderPostDto)
            
        case .createTodo(let parameters):
            let todoPostDto = TodoPostDto(title: parameters.title, content: parameters.content, priority: parameters.priority, wishCompleteDate: parameters.wishCompleteDate, folderId: parameters.folderId, memberId: parameters.memberId)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(todoPostDto)
            
        case .login(let parameters):
            let loginPostDto = LoginPostDto(email: parameters.email, password: parameters.password)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(loginPostDto)
            
        case .deleteTodo(let parameters):
            let deleteTodoDto = DeleteTodoDto(todoId: parameters.todoId)
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(deleteTodoDto)
            
        case .getFolderList:

            return nil
            
        case .getTest:
            return nil
        }
    }
}
