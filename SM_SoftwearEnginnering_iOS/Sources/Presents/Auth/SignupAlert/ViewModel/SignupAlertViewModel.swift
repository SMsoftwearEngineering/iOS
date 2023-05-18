//
//  SignupAlertViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import Foundation
import Combine

final class SignupAlertViewModel: ViewModelType {
    private weak var coordinator: AuthCoordinator?
    private var anyCancellable = Set<AnyCancellable>()

    init(coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let okButtonTap: AnyPublisher<Void, Never>
    }

    struct Output {

    }
    
    func transform(_ input: Input) -> Output {
        input.okButtonTap.sink { [weak self] _ in
            self?.coordinator?.popPopupViewController()
        }
        .store(in: &anyCancellable)
        return Output()
    }
}
