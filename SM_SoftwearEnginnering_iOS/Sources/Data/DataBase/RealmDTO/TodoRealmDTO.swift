//
//  TodoRealmDTO.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

final class TodoRealmDTO: Object {
    @Persisted var todoId: Int
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var completeDate: Date
    @Persisted var priority: Int
    @Persisted var wishCompleteDate: Date
    @Persisted var folderId: Int
    @Persisted var memberId: Int
    @Persisted var done: Bool
    
    @Persisted(primaryKey: true) var objectId: ObjectId

    
    convenience init(todoId: Int, title: String, content: String, completeDate: Date, priority: Int, wishCompleteDate: Date, folderId: Int, memberId: Int, done: Bool) {
        self.init()
        self.todoId = todoId
        self.title = title
        self.content = content
        self.completeDate = completeDate
        self.priority = priority
        self.wishCompleteDate = wishCompleteDate
        self.folderId = folderId
        self.memberId = memberId
        self.done = done
    }
}

extension TodoRealmDTO {
    var toDomain: Todo {
        return Todo(todoId: todoId, title: title, content: content, completeDate: completeDate, priority: priority, wishCompleteDate: wishCompleteDate, folderId: folderId, memberId: memberId, done: done)
    }
}

extension Todo {
    var toRealm: TodoRealmDTO {
        return TodoRealmDTO(todoId: todoId, title: title, content: content, completeDate: completeDate, priority: priority, wishCompleteDate: wishCompleteDate, folderId: folderId, memberId: memberId, done: done)
    }
}
