//
//  LoginRepositoryImpl.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/24.
//

import Foundation
import Combine

final class LoginRepositoryImpl: LoginRepository {
    private let session: Service
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Service) {
        self.session = session
    }
    
    func requestLogin(query: LoginQuery) -> AnyPublisher<Login, NetworkError> {
        return Future<Login, NetworkError> { promise in
            self.session.request(target: Router.login(parameters: query), type: LoginResponseDto.self).sink { completion in
                if case .failure(let error) = completion {
                    switch error {
                    default:
                        promise(.failure(error))
                    }
                }
            } receiveValue: { loginResponseDTO in
                let login = loginResponseDTO.toDomain
                promise(.success(login))
            }
            .store(in: &self.anyCancellable)
        }.eraseToAnyPublisher()
    }
}
