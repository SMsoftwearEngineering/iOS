//
//  TodoRealmDTO.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

final class TodoRealmDTO: Object {
    @Persisted var todoId: ObjectId
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var completeDate: Date
    @Persisted var priority: Int
    @Persisted var wishCompleteDate: Date
    @Persisted var folderId: ObjectId
    @Persisted var memberId: Int
    @Persisted var done: Bool
    @Persisted var color: String
    
    @Persisted(primaryKey: true) var objectId: ObjectId

    
    convenience init(title: String, content: String, completeDate: Date, priority: Int, wishCompleteDate: Date, folderId: ObjectId, memberId: Int, done: Bool, color: String) {
        self.init()
        self.title = title
        self.content = content
        self.completeDate = completeDate
        self.priority = priority
        self.wishCompleteDate = wishCompleteDate
        self.folderId = folderId
        self.memberId = memberId
        self.done = done
        self.color = color
    }
}

extension TodoRealmDTO {
    var toDomain: Todo {
        return Todo(todoId: todoId, title: title, content: content, completeDate: completeDate, priority: priority, wishCompleteDate: wishCompleteDate, folderId: folderId, memberId: memberId, done: done, color: color)
    }
}

extension Todo {
    var toRealm: TodoRealmDTO {
        return TodoRealmDTO(title: title, content: content, completeDate: completeDate, priority: priority, wishCompleteDate: wishCompleteDate, folderId: folderId, memberId: memberId, done: done, color: color)
    }
}
