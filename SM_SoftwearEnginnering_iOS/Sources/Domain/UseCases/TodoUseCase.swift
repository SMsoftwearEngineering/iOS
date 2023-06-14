//
//  TodoUseCase.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

protocol TodoUseCase {
    func load(folderId: ObjectId) -> [Todo]
    func create(with item: Todo)
    func delete(memberId: Int, todoId: ObjectId)
    func updateDone(todo: Todo, done: Bool)
    func finishTodoLoad(finish: Bool) -> [Todo]
}

final class TodoUseCaseImpl: TodoUseCase {
    
    private let todoRealmRepository: TodoRealmRepository
    
    init(todoRealmRepository: TodoRealmRepository) {
        self.todoRealmRepository = todoRealmRepository
    }
    
    func load(folderId: ObjectId) -> [Todo] {
        self.todoRealmRepository.loadTodo(folderId: folderId)
    }
    
    func create(with item: Todo) {
        self.todoRealmRepository.createTodo(todo: item)
    }
    
    func delete(memberId: Int, todoId: ObjectId) {
        self.todoRealmRepository.deleteTodo(memberId: memberId, todoId: todoId)
    }
    
    func updateDone(todo: Todo, done: Bool) {
        self.todoRealmRepository.updateDone(todo: todo, done: done)
    }
    
    func finishTodoLoad(finish: Bool) -> [Todo] {
        self.todoRealmRepository.finishTodoListLoad(finish: finish)
    }
}
