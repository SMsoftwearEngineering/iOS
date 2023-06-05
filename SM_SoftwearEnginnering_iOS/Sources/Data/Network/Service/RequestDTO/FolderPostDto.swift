//
//  FolderPostDto.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation

struct FolderPostDto: Codable {
    
    let folderTitle: String
    let memberId: Int64
    let color: String
    
    enum CodingKeys: String, CodingKey {
        case folderTitle, memberId, color
    }

}

extension FolderPostDto {
    var toDomain: FolderPostQuery {
        return .init(folderTitle: folderTitle, memberId: memberId, color: color)
    }
}
