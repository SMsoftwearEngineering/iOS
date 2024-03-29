//
//  TodoRealmRepositoryImpl.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

final class TodoRealmRepositoryImpl: TodoRealmRepository {
    func finishTodoListLoad(finish: Bool) -> [Todo] {
        return storage.objects(TodoRealmDTO.self).where { $0.done == finish }.toArray.map { $0.toDomain }
    }
    
    
    let storage = try! Realm()
    
    func loadTodo(folderId: ObjectId) -> [Todo] {
        return storage.objects(TodoRealmDTO.self).where { $0.folderId == folderId }.toArray.map { $0.toDomain }
    }
    
    func createTodo(todo: Todo) {
        print("Todo생성")
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
        print("찍히겟지")
        if let todoDTO = storage.objects(TodoRealmDTO.self).first(where: { $0.todoId == todo.todoId
        }) {
            do {
                try storage.write {
                    print(todoDTO,"write찍히나")
                    todoDTO.done = done
                    storage.add(todoDTO, update: .modified)
                }
            } catch let error {
                print(error, "이게찍힘?")
            }
        }
    }
}
