//
//  DeleteTodoRepository.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/24.
//

import Foundation
import Combine

final class DeleteTodoRepositoryImpl: DeleteTodoRepository {
    
    private let session: Service
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Service) {
        self.session = session
    }
    
    func deleteTodo(query: DeleteTodoQuery) -> AnyPublisher<Int, NetworkError> {
        return Future<Int, NetworkError> { promise in
            self.session.statusRequest(target: Router.deleteTodo(parameters: query), type: StatusCodeResponseDTO.self).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { statusCode in
                print("deleteTodo",statusCode)
                promise(.success(statusCode))
            }
            .store(in: &self.anyCancellable)
        }.eraseToAnyPublisher()
    }
}
