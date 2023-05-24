//
//  TodoPostDto.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation

struct TodoPostDto: Codable {
    let title: String
    let content: String
    let priority: Int32
    let wishCompleteDate: String
    let folderId: Int64
    let memberId: Int64
    
    enum CodingKeys: String, CodingKey {
        case title, content, priority, wishCompleteDate, folderId, memberId
    }
}

extension TodoPostDto {
    var toDomain: TodoPostQuery {
        return .init(title: title, content: content, priority: priority, wishCompleteDate: wishCompleteDate, folderId: folderId, memberId: memberId)
    }
}
