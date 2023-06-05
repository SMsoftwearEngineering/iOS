//
//  PostTestResponseDTO.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/01.
//

import Foundation

struct PostTestResponseDTO: Codable {
    let stringTest: String
    let int64Test: Int64
    let int32Test: Int32
    let dateTest: Date
    
    enum CodingKeys: String, CodingKey {
        case stringTest, int64Test, int32Test, dateTest
    }
}

extension PostTestResponseDTO {
    var toDomain: PostTest {
        .init(stringTest: stringTest, int64Test: int64Test, int32Test: int32Test, dateTest: dateTest)
    }
}
