//
//  TargetType.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import Foundation

protocol TargetType {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var header: [String: String]? { get }
    var httpMethod: HTTPMethod { get }
    var parameters: String? { get }
    var port: Int { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension TargetType {
    var components: URLComponents {
        var components = URLComponents()
        components.host = host
        components.path = path
        components.scheme = scheme
        components.port = port
        components.queryItems = queryItems
        return components
    }
    var request: URLRequest {
        guard let url = components.url else { fatalError() }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue.uppercased()
        request.allHTTPHeaderFields = header
        request.httpBody = parameters?.data(using: .utf8)
        request.httpBody = body
        return request
    }
}
