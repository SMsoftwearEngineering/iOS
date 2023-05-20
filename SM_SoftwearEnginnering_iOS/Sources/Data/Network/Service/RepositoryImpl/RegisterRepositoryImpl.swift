//
//  RegisterRepositoryImpl.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/19.
//

import Foundation
import Combine

final class RegisterRepositoryImpl: RegisterRepository {
    
    private let session: Service
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Service) {
        self.session = session
    }
    
    func requestRegister(register: RegisterQuery) -> AnyPublisher<Int, NetworkError> {
        return Future<Int, NetworkError> { promise in
            self.session.statusRequest(target: Router.register(parameters: register), type: StatusCodeResponseDTO.self).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { statusCode in
                print("register",statusCode)
                promise(.success(statusCode))
            }
            .store(in: &self.anyCancellable)
        }.eraseToAnyPublisher()
    }
}
