//
//  DetailTodoViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine

final class DetailTodoViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private var anyCancellable = Set<AnyCancellable>()

    init(coordinator: MainCoordinator?) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let cancelButtonTap: AnyPublisher<Void, Never>
    }

    struct Output {

    }
    
    func transform(_ input: Input) -> Output {
        
        input.cancelButtonTap.sink { [weak self] _ in
            self?.coordinator?.dismissViewController()
        }
        .store(in: &anyCancellable)
        return Output()
    }
}
