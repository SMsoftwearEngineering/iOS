//
//  UpdateMemberDto.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation

struct UpdateMemberDto {
    let memberId: Int64
    let email: String
    let password: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case memberId, email, password, name
    }
}

extension UpdateMemberDto {
    var toDomain: UpdateMemberQuery {
        .init(memberId: memberId, email: email, password: password, name: name)
    }
}
