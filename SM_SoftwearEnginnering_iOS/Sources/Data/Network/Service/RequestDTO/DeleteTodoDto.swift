//
//  DeleteTodoDto.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/24.
//

import Foundation

struct DeleteTodoDto: Codable {
    let todoId: Int64
    
    enum CodingKeys: String, CodingKey {
        case todoId
    }
}

extension DeleteTodoDto {
    var toDomain: DeleteTodoQuery {
        return .init(todoId: todoId)
    }
}
