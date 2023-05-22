//
//  UpdateFolderDto.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation

struct UpdateFolderDto: Codable {
    let folderId: Int64
    let folderTitle: String
    let color: String
    
    enum CodingKeys: String, CodingKey {
        case folderId, folderTitle, color
    }
}

extension UpdateFolderDto {
    var toDomain: UpdateFolderQuery {
        return .init(folderId: folderId, folderTitle: folderTitle, color: color)
    }
}
