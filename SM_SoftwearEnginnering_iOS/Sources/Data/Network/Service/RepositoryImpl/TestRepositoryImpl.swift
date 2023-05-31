//
//  TestRepositoryImpl.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/31.
//

import Foundation
import Combine

final class TestRepositoryImpl: TestRepository {
    
    private let session: Service
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Service) {
        self.session = session
    }
    
    func getTest(query: TestQuery) -> AnyPublisher<Test, NetworkError> {
        return Future<Test, NetworkError> { promise in
            self.session.request(target: Router.getTest(parameters: query), type: TestResponseDTO.self).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { TestDTO in
                let test = TestDTO.toDomain
                promise(.success(test))
            }
            .store(in: &self.anyCancellable)
        }.eraseToAnyPublisher()
    }
}
