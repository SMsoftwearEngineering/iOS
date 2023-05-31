//
//  TestResponseDTO.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/31.
//

struct TestResponseDTO: Codable {
    let memberId: Int64
    let email: String
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case memberId, email, name
    }
}

extension TestResponseDTO {
    var toDomain: Test {
        .init(memberId: memberId, email: email, name: name)
    }
}
