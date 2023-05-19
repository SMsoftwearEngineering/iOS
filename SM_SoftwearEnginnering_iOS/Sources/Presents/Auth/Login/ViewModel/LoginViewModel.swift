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
    private let registerUseCase: RegisterUseCase
    
    init(registerUseCase: RegisterUseCase, coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
        self.registerUseCase = registerUseCase
    }
    
    struct Input {
        let signupButtonTap: AnyPublisher<Void, Never>
        let loginButtonTap: AnyPublisher<Void, Never>
        let idText: AnyPublisher<String, Never>
        let pwText: AnyPublisher<String, Never>

    }

    struct Output {

    }
    
    var idText: String?
    var pwText: String?
    var errorPublisher = PassthroughSubject<String?, Never>()
    
    func transform(_ input: Input) -> Output {
        input.loginButtonTap.sink { [weak self] _ in
            print("로그인버튼클릭")
            guard let idText = self?.idText, let pwText = self?.pwText else { return }

            self?.registerUseCase.excute(id: self?.idText ?? "", password: self?.pwText ?? "").sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case .failure(let error) = completion {
                    self.errorPublisher.send(error.localizedDescription)
                }
            }, receiveValue: { [weak self] statusCode in
                switch statusCode {
                case 200:
                    
                     self?.coordinator?.showSignupAlertViewController()
                default:
                     self?.coordinator?.showSignupViewController()
                }
            })
        }
        .store(in: &anyCancellable)

        input.signupButtonTap.sink { [weak self] _ in
            self?.coordinator?.showSignupViewController()
        }
        .store(in: &anyCancellable)
        
        input.idText
            .sink { [weak self] idText in
                self?.idText = idText
            }
            .store(in: &anyCancellable)
        
        input.pwText
            .sink { [weak self] pwText in
                self?.pwText = pwText
            }
            .store(in: &anyCancellable)
        
        return Output()
    }
}
