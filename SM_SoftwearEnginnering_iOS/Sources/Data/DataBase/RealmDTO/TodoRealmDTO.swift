//
//  TodoRealmDTO.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

final class TodoRealmDTO: Object {
    @Persisted var todoId: Int64
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var completeDate: Date
    @Persisted var priority: Int32
    @Persisted var wishCompleteDate: Date
    @Persisted var folderId: Int64
    @Persisted var memberId: Int64
    @Persisted var done: Bool
    
    convenience init(todo: Todo) {
        self.init()
        self.todoId = todo.todoId
        self.title = todo.title
        self.content = todo.content
        self.completeDate = todo.completeDate
        self.priority = todo.priority
        self.wishCompleteDate = todo.wishCompleteDate
        self.folderId = todo.folderId
        self.memberId = todo.memberId
        self.done = todo.done
    }
}

extension TodoRealmDTO {
    func toDomain() -> Todo {
        return .init(todoId: todoId, title: title, content: content, completeDate: completeDate, priority: priority, wishCompleteDate: wishCompleteDate, folderId: folderId, memberId: memberId, done: done)
    }
}
