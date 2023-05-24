//
//  CreateTodoUseCase.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine

protocol CreateTodoUseCase {
    func excute(title: String, content: String, priority: Int32, wishCompleteDate: String, folderId: Int64, memberId: Int64) -> AnyPublisher<Int, NetworkError>
}

final class CreateTodoUseCaseImpl: CreateTodoUseCase {
    let createTodoRepository: CreateTodoRepository
    private var anyCancellable = Set<AnyCancellable>()
    
    init(createTodoRepository: CreateTodoRepository) {
        self.createTodoRepository = createTodoRepository
    }
    
    func excute(title: String, content: String, priority: Int32, wishCompleteDate: String, folderId: Int64, memberId: Int64) -> AnyPublisher<Int, NetworkError> {
        let todoPostQuery = TodoPostQuery(title: title, content: content, priority: priority, wishCompleteDate: wishCompleteDate, folderId: folderId, memberId: memberId)
        return Future<Int, NetworkError> { [weak self] promiss in
            guard let self else { return }
            print("서버에게 보내는 Query", todoPostQuery)
            self.createTodoRepository.requestCreateTodo(query: todoPostQuery).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promiss(.failure(error))
                    }
                }
            } receiveValue: { statusCode in
                print("UseCase",statusCode)
                promiss(.success(statusCode))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
}
