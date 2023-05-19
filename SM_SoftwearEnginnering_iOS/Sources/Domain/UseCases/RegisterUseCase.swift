//
//  RegisterUseCase.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import Foundation
import Combine

protocol RegisterUseCase {
    func excute(id: String, password: String) -> AnyPublisher<Int, NetworkError>
}

final class RegisterUseCaseImpl: RegisterUseCase {
    let registerRepository: RegisterRepository
    private var anyCancellable = Set<AnyCancellable>()
    
    init(registerRepository: RegisterRepository) {
        self.registerRepository = registerRepository
    }
    
    func excute(id: String, password: String) -> AnyPublisher<Int, NetworkError> {
        let registerQuery = RegisterQuery(email: "qudgus1984", name: "이병현", password: "qwer1234!")
        return Future<Int, NetworkError> { [weak self] promiss in
            guard let self else { return }
            self.registerRepository.requestRegister(register: registerQuery).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promiss(.failure(error))
                    }
                }
            } receiveValue: { statusCode in
                promiss(.success(statusCode))
            }
            .store(in: &self.anyCancellable)
        }
        .eraseToAnyPublisher()
    }
}
