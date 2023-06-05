//
//  PostTestRepositoryImpl.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/01.
//

import Foundation
import Combine

final class PostTestRepositoryImpl: PostTestRepository {
    
    private let session: Service
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Service) {
        self.session = session
    }
    
    func postTest(query: PostTestQuery) -> AnyPublisher<PostTest, NetworkError> {
        return Future<PostTest, NetworkError> { promise in
            self.session.request(target: Router.postTest(parameters: query), type: PostTestResponseDTO.self).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { postTestDTO in
                let test = postTestDTO.toDomain
                print("Repository", test)
                promise(.success(test))
            }
            .store(in: &self.anyCancellable)
        }.eraseToAnyPublisher()
    }
}
