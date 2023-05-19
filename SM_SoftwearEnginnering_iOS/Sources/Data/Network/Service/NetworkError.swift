//
//  NetworkError.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import Foundation

enum NetworkError: Error {
    case unexpectedData
    case decodingError
    case clientError
    case serverError
    case internalError
}
