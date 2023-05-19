//
//  RegisterRequestDTO.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/19.
//

import Foundation

struct RegisterRequestDTO: Codable {
    let email: String
    let name: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email, name, password
    }
}

extension RegisterRequestDTO {
    var toDomain: RegisterQuery {
        return .init(email: email, name: name, password: password)
    }
}
