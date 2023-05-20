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
    
    var idText = CurrentValueSubject<String, Never>("")
    var pwText = CurrentValueSubject<String, Never>("")
    var errorPublisher = PassthroughSubject<String?, Never>()
    
    func transform(_ input: Input) -> Output {

        input.signUpButtonTap
            .map {
                self.registerUseCase.excute(id: self.idText.value ?? "", password: self.pwText.value ?? "")
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { status in
                switch status {
                case 200:
                    self.coordinator?.showLoginViewController()
                default:
                    print(status, "error")
                }
            }
            .store(in: &anyCancellable)

        input.idText
            .sink { [weak self] idText in
                self?.idText.value = idText
            }
            .store(in: &anyCancellable)
        
        input.confirmPwText
            .sink { [weak self] confirmPwText in
                self?.pwText.value = confirmPwText
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
