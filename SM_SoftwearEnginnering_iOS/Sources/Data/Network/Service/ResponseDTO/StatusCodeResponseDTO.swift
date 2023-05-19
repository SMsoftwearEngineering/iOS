//
//  RegisterResponseDTO.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/19.
//

import Foundation

struct StatusCodeResponseDTO: Decodable {
    let statusCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
    }
}

