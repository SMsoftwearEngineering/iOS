//
//  TodoUpdateDto.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation

struct TodoUpdateDto: Codable {
    let todoId: Int64
    let title: String
    let content: String
    let priority: Int32
    let wishCompleteDate: Date
    let folderId: Int64
    
    enum CodingKeys: String, CodingKey {
        case todoId, title, content, priority, wishCompleteDate, folderId
    }
}

extension TodoUpdateDto {
    var toDomain: TodoUpdateQuery {
        return .init(todoId: todoId, title: title, content: content, priority: priority, wishCompleteDate: wishCompleteDate, folderId: folderId)
    }
}
