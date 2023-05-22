//
//  DeleteFolderAlertViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine

final class DeleteFolderAlertViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private var anyCancellable = Set<AnyCancellable>()

    init(coordinator: MainCoordinator?) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let okButtonTap: AnyPublisher<Void, Never>
        let noButtonTap: AnyPublisher<Void, Never>
    }

    struct Output {

    }
    
    func transform(_ input: Input) -> Output {
        input.okButtonTap.sink { [weak self] _ in
            self?.coordinator?.popPopupViewController()
        }
        .store(in: &anyCancellable)
        
        input.noButtonTap.sink { [weak self] _ in
            self?.coordinator?.popPopupViewController()
        }
        .store(in: &anyCancellable)
        return Output()
    }
}
