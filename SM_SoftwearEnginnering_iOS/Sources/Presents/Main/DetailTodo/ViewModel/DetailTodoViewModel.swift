//
//  DetailTodoViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine

final class DetailTodoViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private var anyCancellable = Set<AnyCancellable>()
    private var todo: CurrentValueSubject<Todo, Never>

    init(coordinator: MainCoordinator?, todo: Todo) {
        self.coordinator = coordinator
        self.todo = CurrentValueSubject(todo)
    }
    
    struct Input {
        let cancelButtonTap: AnyPublisher<Void, Never>
    }

    struct Output {
        let todoPublish: AnyPublisher<Todo, Never>
    }
    
    func transform(_ input: Input) -> Output {
        
        input.cancelButtonTap.sink { [weak self] _ in
            self?.coordinator?.dismissViewController()
        }
        .store(in: &anyCancellable)
        
        let todoPublish = self.todo.eraseToAnyPublisher()
        return Output(todoPublish: todoPublish)
    }
}
