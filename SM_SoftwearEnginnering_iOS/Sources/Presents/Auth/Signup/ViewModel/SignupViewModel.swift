//
//  SignupViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import Foundation

final class SignupViewModel: ViewModelType {
    private weak var coordinator: AuthCoordinator?

    init(coordinator: AuthCoordinator?) {
        self.coordinator = coordinator
    }
    
    struct Input {

    }

    struct Output {

    }
    
    func transform(_ input: Input) -> Output {
        return Output()
    }
}
