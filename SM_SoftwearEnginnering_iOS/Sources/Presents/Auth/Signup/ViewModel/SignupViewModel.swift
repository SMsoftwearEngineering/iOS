//
//  SignupViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import Foundation
import Combine

final class SignupViewModel: ViewModelType {
    private weak var coordinator: AuthCoordinator?
    private var anyCancellable = Set<AnyCancellable>()
    private let registerUseCase: RegisterUseCase

    init(coordinator: AuthCoordinator?, registerUseCase: RegisterUseCase) {
        self.registerUseCase = registerUseCase
        self.coordinator = coordinator
    }
    
    struct Input {
        let idText: AnyPublisher<String, Never>
        let pwText: AnyPublisher<String, Never>
        let confirmPwText: AnyPublisher<String, Never>
        let signUpButtonTap: AnyPublisher<Void, Never>
    }

    struct Output {
        let signUpValid: AnyPublisher<Bool, Never>
    }
    
    var idText: String?
    var pwText: String?
    var errorPublisher = PassthroughSubject<String?, Never>()
    
    func transform(_ input: Input) -> Output {
        input.signUpButtonTap.sink { [weak self] _ in
            guard let idText = self?.idText, let pwText = self?.pwText else { return }
            
            self?.registerUseCase.excute(id: self?.idText ?? "", password: self?.pwText ?? "").sink { [weak self] completion in
                guard let self = self else { return }
                if case .failure(let error) = completion {
                    self.errorPublisher.send(error.localizedDescription)
                }
            } receiveValue: { [weak self] statusCode in
                switch statusCode {
                case 200:
                    self?.coordinator?.showLoginViewController()
                default:
                    print(statusCode, "회원가입이 실패요")
                }
            }
        }
        .store(in: &anyCancellable)
        
        
        input.idText
            .sink { [weak self] idText in
                self?.idText = idText
            }
            .store(in: &anyCancellable)
        
        input.confirmPwText
            .sink { [weak self] confirmPwText in
                self?.pwText = confirmPwText
            }
            .store(in: &anyCancellable)

        
        let signUpValid = Publishers.CombineLatest(input.pwText, input.confirmPwText)
            .map { pwText, confirmPwText in
                return pwText == confirmPwText
            }
            .eraseToAnyPublisher()
        
        return Output(signUpValid: signUpValid)
    }
}
