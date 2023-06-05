//
//  PostTestRequestDTO.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/01.
//

import Foundation

struct PostTestRequestDTO: Codable {
    let stringTest: String
    let int64Test: Int64
    let int32Test: Int32
    let dateTest: Date
    
    enum CodingKeys: String, CodingKey {
        case stringTest, int64Test, int32Test, dateTest
    }
}
