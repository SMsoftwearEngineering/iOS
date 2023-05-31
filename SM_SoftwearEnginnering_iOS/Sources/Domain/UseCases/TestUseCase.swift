//
//  TestUseCase.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/31.
//

import Foundation
import Combine

protocol TestUseCase {
    func excute(memberId: Int64) -> AnyPublisher<Test, NetworkError>
}

final class TestUseCaseImpl: TestUseCase {
    
    let testRepository: TestRepository
    private var anyCancellable = Set<AnyCancellable>()
    
    init(testRepository: TestRepository) {
        self.testRepository = testRepository
    }
    
    func excute(memberId: Int64) -> AnyPublisher<Test, NetworkError> {
        let query = TestQuery(memberId: memberId)
        return Future<Test, NetworkError> { [weak self] promise in
            guard let self else { return }
            self.testRepository.getTest(query: TestQuery(memberId: memberId)).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { login in
                print("loginResponse", login)
                promise(.success(login))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
}
