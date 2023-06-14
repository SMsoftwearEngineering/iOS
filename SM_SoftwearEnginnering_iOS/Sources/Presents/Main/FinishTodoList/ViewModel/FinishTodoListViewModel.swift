//
//  FinishTodoListViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/14.
//

import Foundation
import Combine
import RealmSwift

final class FinishTodoListViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private let todoUseCase: TodoUseCase
    private var anyCancellable = Set<AnyCancellable>()

    init(coordinator: MainCoordinator?, todoUseCase: TodoUseCase) {
        self.coordinator = coordinator
        self.todoUseCase = todoUseCase
    }

    struct Input {
        let todoCreateButtonTap: AnyPublisher<Void, Never>
        let filterButtonTap: AnyPublisher<Void, Never>
        let backButtonTap: AnyPublisher<Void, Never>
        let deleteButtonTap: AnyPublisher<Todo, Never>
        let cellButtonTap: AnyPublisher<Todo, Never>
        let viewDidLoad: AnyPublisher<Void, Never>
        let checkButtonTap: AnyPublisher<Todo, Never>
    }

    struct Output {
        let todoPublish: AnyPublisher<[Todo], Never>
    }
    
    private let localRealm = try? Realm()
    var todoListPublish = CurrentValueSubject<[Todo], Never>([])
    private var notificationToken: NotificationToken?

    func transform(_ input: Input) -> Output {


        input.backButtonTap.sink { [weak self] _ in
            self?.coordinator?.popViewController()
        }
        .store(in: &anyCancellable)

        
        input.cellButtonTap.sink { [weak self] todo in
            self?.coordinator?.showDetailTodoViewController(todo: todo)
        }
        .store(in: &anyCancellable)
        
        input.checkButtonTap.sink { todo in
            var todoDone = todo.done ? false : true
            self.updateDone(todo: todo, done: todoDone)
            self.todoListPublish.send(self.fetchFinishTodo())
        }
        .store(in: &anyCancellable)
        
        input.deleteButtonTap.sink { todo in
            self.coordinator?.showDeleteTodoAlertViewController(todo: todo)
        }
        .store(in: &anyCancellable)

        
        input.viewDidLoad
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.todoListPublish.send(self.fetchFinishTodo())
            }
            .store(in: &anyCancellable)
        
        let todoListPublish = self.todoListPublish.eraseToAnyPublisher()
        return Output(todoPublish: todoListPublish)
    }
}

extension FinishTodoListViewModel {
    func fetchFinishTodo() -> [Todo] {
        notificationToken?.invalidate()

        let todo = todoUseCase.finishTodoLoad(finish: true)
        notificationToken = localRealm?.observe { [weak self] _, _ in
            let todo = self?.todoUseCase.finishTodoLoad(finish: true)
            self?.todoListPublish.send(todo ?? [Todo(todoId: ObjectId(), title: "", content: "", completeDate: Date(), priority: 0, wishCompleteDate: Date(), folderId: ObjectId(), memberId: 0, done: false, color: "")])
        }
        return todo
    }
    
    func updateDone(todo: Todo, done: Bool) {
        todoUseCase.updateDone(todo: todo, done: done)
    }
    
    func deleteTodo(todo: Todo) {
        todoUseCase.delete(memberId: todo.memberId, todoId: todo.todoId)
    }
}
