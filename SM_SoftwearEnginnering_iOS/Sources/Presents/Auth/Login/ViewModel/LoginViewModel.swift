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
    private let loginUseCase: LoginUseCase

    
    init(loginUseCase: LoginUseCase, coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
        self.loginUseCase = loginUseCase
    }
    
    struct Input {
        let signupButtonTap: AnyPublisher<Void, Never>
        let loginButtonTap: AnyPublisher<Void, Never>
        let idText: AnyPublisher<String, Never>
        let pwText: AnyPublisher<String, Never>

    }

    struct Output {

    }
    
    var idText = CurrentValueSubject<String, Never>("")
    var pwText = CurrentValueSubject<String, Never>("")
    var errorPublisher = PassthroughSubject<String?, Never>()
    
    func transform(_ input: Input) -> Output {
//        input.loginButtonTap
//            .map {
//                self.registerUseCase.excute(id: self.idText.value ?? "", password: self.pwText.value ?? "")
//            }
//            .switchToLatest()
//            .receive(on: DispatchQueue.main)
//            .sink { error in
//                print(error)
//            } receiveValue: { status in
//                switch status {
//                case 200:
//                    self.coordinator?.connectHomeCoordinator()
//                default:
//                    print(status, "error")
//                }
//            }
//            .store(in: &anyCancellable)
        
        input.loginButtonTap.map {
            self.loginUseCase.excute(id: self.idText.value ?? "", password: self.pwText.value ?? "")
        }
        .switchToLatest()
        .receive(on: DispatchQueue.main)
        .sink { error in
            print(error)
        } receiveValue: { login in
            print(login)
            UserDefaults.standard.set(Int(login.memberId), forKey: "memberId")
            UserDefaults.standard.set(login.token, forKey: "token")
            print("토큰받아져왔다.:",login.token)
            UserDefaults.standard.set(login.email, forKey: "id")
            self.coordinator?.connectHomeCoordinator()
        }
        .store(in: &anyCancellable)


        input.signupButtonTap.sink { [weak self] _ in
            self?.coordinator?.showSignupViewController()
        }
        .store(in: &anyCancellable)
        
        input.idText
            .sink { [weak self] idText in
                self?.idText.value = idText
            }
            .store(in: &anyCancellable)
        
        input.pwText
            .sink { [weak self] pwText in
                self?.pwText.value = pwText
            }
            .store(in: &anyCancellable)
        
        return Output()
    }
}
