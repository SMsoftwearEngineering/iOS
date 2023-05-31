//
//  GetFolderListDTO.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/26.
//

import Foundation

struct GetFolderListDTO: Codable {
    let userId: Int64
    let pageNo: Int32
    let pageSize: Int32
    let sortBy: String
    
    enum CodingKeys: String, CodingKey {
        case userId, pageNo, pageSize, sortBy
    }
}

