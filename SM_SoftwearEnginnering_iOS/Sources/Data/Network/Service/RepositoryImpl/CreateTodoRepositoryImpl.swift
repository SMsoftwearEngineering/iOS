//
//  CreateTodoRepository.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine

final class CreateTodoRepositoryImpl: CreateTodoRepository {
    private let session: Service
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Service) {
        self.session = session
    }
    
    func requestCreateTodo(query: TodoPostQuery) -> AnyPublisher<Int, NetworkError> {
        return Future<Int, NetworkError> { promise in
            self.session.statusRequest(target: Router.createTodo(parameters: query), type: StatusCodeResponseDTO.self).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { statusCode in
                print("todoPost",statusCode)
                promise(.success(statusCode))
            }
            .store(in: &self.anyCancellable)
        }.eraseToAnyPublisher()
    }
}
