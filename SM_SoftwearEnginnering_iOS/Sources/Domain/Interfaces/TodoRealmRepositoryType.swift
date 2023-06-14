//
//  TodoRealmRepositoryType.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

protocol TodoRealmRepository: AnyObject {
    
    func loadTodo(folderId: ObjectId) -> [Todo]
    
    func createTodo(todo: Todo)
    
    func deleteTodo(memberId: Int, todoId: ObjectId)
        
    func updateDone(todo: Todo, done: Bool)
    
    func finishTodoListLoad(finish: Bool) -> [Todo]
}
