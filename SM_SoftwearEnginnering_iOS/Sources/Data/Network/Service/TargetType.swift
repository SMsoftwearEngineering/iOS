//
//  TargetType.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import Foundation

enum Test {
    case register(parameters: RegisterQuery)

    func request(completion: @escaping (Result<Data, Error>) -> Void) {
        let router: Router

        switch self {
        case .register(let parameters):
            router = .register(parameters: RegisterQuery(email: parameters.email, name: parameters.name, password: parameters.password))
        }

        let request = router.buildRequest()
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let response = response as? HTTPURLResponse {
                print("statusCode",response.statusCode)
            }

            guard let data = data else {
                let emptyDataError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Empty response data"])
                completion(.failure(emptyDataError))
                return
            }
            print("✅✅✅데이터",data)
            completion(.success(data))
        }

        task.resume()
    }
}

protocol TargetType {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var header: [String: String]? { get }
    var httpMethod: HTTPMethod { get }
    var parameters: String? { get }
    var port: Int { get }
    var body: Data? { get }
}

extension TargetType {
    var components: URLComponents {
        var components = URLComponents()
        components.host = host
        components.path = path
        components.scheme = scheme
        components.port = port
        return components
    }
    var request: URLRequest {
        guard let url = components.url else { fatalError() }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue.uppercased()
        request.allHTTPHeaderFields = header
        request.httpBody = parameters?.data(using: .utf8)
        request.httpBody = body
//        print("header",request.allHTTPHeaderFields)
        return request
    }
}
