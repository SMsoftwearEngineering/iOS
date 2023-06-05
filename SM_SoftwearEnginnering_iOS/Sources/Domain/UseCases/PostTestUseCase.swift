//
//  PostTestUseCase.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/01.
//

import Foundation
import Combine

protocol PostTestUseCase {
    func excute() -> AnyPublisher<PostTest, NetworkError>
}

final class PostTestUseCaseImpl: PostTestUseCase {
    let postTestRepository: PostTestRepository
    private var anyCancellable = Set<AnyCancellable>()
    
    init(postTestRepository: PostTestRepository) {
        self.postTestRepository = postTestRepository
    }
    
    func excute() -> AnyPublisher<PostTest, NetworkError> {
        let query = PostTestQuery(string: "Test", int64: Int64(64), int32: Int32(32), date: Date())
        return Future<PostTest, NetworkError> { [weak self] promise in
            guard let self else { return }
            self.postTestRepository.postTest(query: query).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { test in
                print("postTest", test)
                promise(.success(test))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
    
}
