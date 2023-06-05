//
//  TodoListViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine
import RealmSwift

final class TodoListViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private let todoUseCase: TodoUseCase
    private var anyCancellable = Set<AnyCancellable>()
    private var folderSubject: CurrentValueSubject<Folder, Never>

    init(coordinator: MainCoordinator?, folder: Folder, todoUseCase: TodoUseCase) {
        self.coordinator = coordinator
        self.folderSubject = CurrentValueSubject(folder)
        self.todoUseCase = todoUseCase
    }

    struct Input {
        let todoCreateButtonTap: AnyPublisher<Void, Never>
        let filterButtonTap: AnyPublisher<Void, Never>
        let backButtonTap: AnyPublisher<Void, Never>
        let deleteButtonTap: AnyPublisher<Void, Never>
        let cellButtonTap: AnyPublisher<Void, Never>
        let viewDidLoad: AnyPublisher<Void, Never>
        let checkButtonTap: AnyPublisher<Todo, Never>
    }

    struct Output {
        let folderPublish: AnyPublisher<Folder, Never>
        let todoPublish: AnyPublisher<[Todo?]?, Never>
    }
    
    var todoListPublish = CurrentValueSubject<[Todo?]?, Never>([])


    func transform(_ input: Input) -> Output {
        input.viewDidLoad.sink { _ in
            print("viewDidLoad")
            print(self.folderSubject.value.folderId, "folderId")
        }
        .store(in: &anyCancellable)

        input.backButtonTap.sink { [weak self] _ in
            self?.coordinator?.popViewController()
        }
        .store(in: &anyCancellable)

        input.todoCreateButtonTap.sink { [weak self] _ in
            self?.coordinator?.showCreateTodoViewController(folderId: self?.folderSubject.value.folderId ?? ObjectId())
        }
        .store(in: &anyCancellable)

        input.cellButtonTap.sink { [weak self] _ in
            self?.coordinator?.showDetailTodoViewController()
        }
        .store(in: &anyCancellable)
        
        input.checkButtonTap.sink { todo in
            print("버튼클릭은먹니")
            self.updateDone(todo: todo, done: true)
            print(todo, "todo정보임")
        }
        .store(in: &anyCancellable)

        let folderPublish = folderSubject.eraseToAnyPublisher()
        
        input.viewDidLoad
            .sink { [weak self] _ in
                self?.todoListPublish.send(self?.fetchTodo(folderId: self?.folderSubject.value.folderId ?? ObjectId()))
            }
            .store(in: &anyCancellable)
        
        let todoListPublish = self.todoListPublish.eraseToAnyPublisher()
        return Output(folderPublish: folderPublish, todoPublish: todoListPublish)
    }
}

extension TodoListViewModel {
    func fetchTodo(folderId: ObjectId) -> [Todo?] {
        todoUseCase.load(folderId: folderId)
    }
    
    func updateDone(todo: Todo, done: Bool) {
        todoUseCase.updateDone(todo: todo, done: done)
    }
}
