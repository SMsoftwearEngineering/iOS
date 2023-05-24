//
//  LoginResponseDto.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/24.
//

import Foundation

struct LoginResponseDto: Codable {
    let email: String
    let password: String
    let memberId: Int64
    
    enum CodingKeys: String, CodingKey {
        case email, password, memberId
    }
}

extension LoginResponseDto {
    var toDomain: Login {
        .init(email: email, password: password, memberId: memberId)
    }
}
