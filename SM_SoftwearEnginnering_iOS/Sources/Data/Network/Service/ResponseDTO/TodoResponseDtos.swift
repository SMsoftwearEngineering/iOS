//
//  TodoResponseDto.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation

struct TodoResponseDtos: Codable {
    let todoId: Int64
    let title: String
    let content: String
    let completeDate: Date
    let priority: Int32
    let wishCompleteDate: Date
    let folderId: Int64
    let memberId: Int64
    let done: Bool
    
    enum CodingKeys: String, CodingKey {
        case todoId, title, content, completeDate, priority, wishCompleteDate, folderId, memberId, done
    }
}

extension TodoResponseDtos {
    var toDomain: Todo {
        .init(todoId: todoId, title: title, content: content, completeDate: completeDate, priority: priority, wishCompleteDate: wishCompleteDate, folderId: folderId, memberId: memberId, done: done)
    }
}
