//
//  FolderResponseDto.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation

struct FolderResponseDto {
    let folderId: Int64
    let color: String
    let folderTitle: String
    let memberId: Int64
    let todoResponseDtos: [TodoResponseDto]
    
    enum CodingKeys: String, CodingKey {
        case folderId, color, folderTitle, memberId, todoResponseDtos
    }
}

extension FolderResponseDto {
    var toDomain: Folder {
        .init(folderId: folderId, color: color, folderTitle: folderTitle, memberId: memberId, todo: todoResponseDtos.map { $0.toDomain })
    }
}
