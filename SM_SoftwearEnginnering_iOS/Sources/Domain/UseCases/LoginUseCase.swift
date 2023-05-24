//
//  LoginUseCase.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/24.
//

import Foundation
import Combine

protocol LoginUseCase {
    func excute(id: String, password: String) -> AnyPublisher<Login, NetworkError>
}

final class LoginUseCaseImpl: LoginUseCase {
    let loginRepository: LoginRepository
    private var anyCancellable = Set<AnyCancellable>()
    
    init(loginRepository: LoginRepository) {
        self.loginRepository = loginRepository
    }
    
    func excute(id: String, password: String) -> AnyPublisher<Login, NetworkError> {
        let loginQuery = LoginQuery(email: id, password: password)
        return Future<Login, NetworkError> { [weak self] promise in
            guard let self else { return }
            print("Login Query", loginQuery)
            self.loginRepository.requestLogin(query: loginQuery).sink { completion in
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
