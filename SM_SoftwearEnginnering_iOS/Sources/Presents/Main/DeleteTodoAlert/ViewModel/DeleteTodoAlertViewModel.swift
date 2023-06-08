//
//  DeleteTodoAlertViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/08.
//

import Foundation
import Combine
import RealmSwift

final class DeleteTodoAlertViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private var anyCancellable = Set<AnyCancellable>()
    private let todoUseCase: TodoUseCase
    private var todo: CurrentValueSubject<Todo, Never>


    init(coordinator: MainCoordinator?, todoUseCase: TodoUseCase, todo: Todo) {
        self.coordinator = coordinator
        self.todoUseCase = todoUseCase
        self.todo = CurrentValueSubject(todo)
    }
    
    struct Input {
        let okButtonTap: AnyPublisher<Void, Never>
        let noButtonTap: AnyPublisher<Void, Never>
    }

    struct Output {

    }
    
    func transform(_ input: Input) -> Output {
        input.okButtonTap.sink { [weak self] _ in
            self?.todoUseCase.delete(memberId: self?.todo.value.memberId ?? 0, todoId: self?.todo.value.todoId ?? ObjectId())
            self?.coordinator?.dismissViewController()
        }
        .store(in: &anyCancellable)
        
        input.noButtonTap.sink { [weak self] _ in
            self?.coordinator?.dismissViewController()
        }
        .store(in: &anyCancellable)
        return Output()
    }
}

extension DeleteTodoAlertViewModel {
    func deleteTodo(todo: Todo) {
        todoUseCase.delete(memberId: todo.memberId, todoId: todo.todoId)
    }
}
