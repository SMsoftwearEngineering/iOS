//
//  DeleteTodoUseCase.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/24.
//

import Foundation
import Combine

protocol DeleteTodoUseCase {
    func excute(todoId: Int64) -> AnyPublisher<Int, NetworkError>
}

final class DeleteTodoUseCaseImpl: DeleteTodoUseCase {
    let deleteTodoRepository: DeleteTodoRepository
    private var anyCancellable = Set<AnyCancellable>()
    
    init(deleteTodoRepository: DeleteTodoRepository) {
        self.deleteTodoRepository = deleteTodoRepository
    }
    
    func excute(todoId: Int64) -> AnyPublisher<Int, NetworkError> {
        let deleteTodoQuery = DeleteTodoQuery(todoId: todoId)
        return Future<Int, NetworkError> { [weak self] promise in
            guard let self else { return }
            print("deleteTodoQuery", deleteTodoQuery)
            self.deleteTodoRepository.deleteTodo(query: deleteTodoQuery).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { statusCode in
                print("UseCase",statusCode)
                promise(.success(statusCode))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
}
