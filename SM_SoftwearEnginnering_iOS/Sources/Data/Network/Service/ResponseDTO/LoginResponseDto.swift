//
//  LoginResponseDto.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/24.
//

import Foundation

struct LoginResponseDto: Codable {
    let memberId: Int64
    let email: String
    let name: String?
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case memberId, email, name, token
    }
}

extension LoginResponseDto {
    var toDomain: Login {
        .init(memberId: memberId, email: email, name: name, token: token)
    }
}
