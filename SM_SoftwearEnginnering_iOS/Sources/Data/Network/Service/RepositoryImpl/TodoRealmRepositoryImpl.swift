//
//  TodoRealmRepositoryImpl.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

final class TodoRealmRepositoryImpl: TodoRealmRepository {
    
    let storage = try! Realm()

    func loadTodo(folderId: ObjectId) -> [Todo] {
        return storage.objects(TodoRealmDTO.self).where { $0.folderId == folderId }.toArray.map { $0.toDomain }
    }
    
    func createTodo(todo: Todo) {
        do {
            try storage.write {
                storage.add(todo.toRealm)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteTodo(memberId: Int, todoId: ObjectId) {
        if let todo = storage.objects(TodoRealmDTO.self).first(where: {
            $0.memberId == memberId && $0.todoId == todoId
        }) {
            do {
                try storage.write {
                    storage.delete(todo)
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    func updateDone(todo: Todo, done: Bool) {
        if let todoDTO = storage.object(ofType: TodoRealmDTO.self, forPrimaryKey: todo.todoId) {
            do {
                try storage.write {
                    todoDTO.done = done
                    storage.add(todoDTO, update: .modified)
                }
            } catch let error {
                print(error)
            }
        }
    }
}
