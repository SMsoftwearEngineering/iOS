//
//  LoginViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import Foundation
import Combine

final class LoginViewModel: ViewModelType {
    private weak var coordinator: AuthCoordinator?
    private var anyCancellable = Set<AnyCancellable>()

    init(coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let signupButtonTap: AnyPublisher<Void, Never>
        let loginButtonTap: AnyPublisher<Void, Never>

    }

    struct Output {

    }
    
    func transform(_ input: Input) -> Output {
        input.loginButtonTap.sink { [weak self] _ in
            print("로그인버튼클릭")
            self?.coordinator?.showSignupAlertViewController()
        }
        .store(in: &anyCancellable)

        input.signupButtonTap.sink { [weak self] _ in
            self?.coordinator?.showSignupViewController()
        }
        .store(in: &anyCancellable)
        return Output()
    }
}
