//
//  LoginPostDto.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/24.
//

import Foundation

struct LoginPostDto: Codable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email, password
    }
}

extension LoginPostDto {
    var toDomain: LoginQuery {
        return .init(email: email, password: password)
    }
}
