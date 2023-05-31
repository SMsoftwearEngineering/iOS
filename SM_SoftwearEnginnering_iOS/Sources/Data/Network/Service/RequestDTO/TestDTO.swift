//
//  TestDTO.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/31.
//

//

import Foundation

struct TestDTO: Codable {
    let memberId: Int64
    
    enum CodingKeys: String, CodingKey {
        case memberId
    }
}

