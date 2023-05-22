//
//  HomeViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation
import Combine

final class HomeViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private var anyCancellable = Set<AnyCancellable>()

    init(coordinator: MainCoordinator?) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let logoutButtonTap: AnyPublisher<Void, Never>
        let folderCreateButtonTap: AnyPublisher<Void, Never>
        let filterButtonTap: AnyPublisher<Void, Never>
        let finishTaskListButtonTap: AnyPublisher<Void, Never>
        let deleteButtonTap: AnyPublisher<Void, Never>

    }

    struct Output {

    }
    
    func transform(_ input: Input) -> Output {
        input.logoutButtonTap.sink { [weak self] _ in
            print("logoutButton 클릭")
        }
        .store(in: &anyCancellable)
        
        input.folderCreateButtonTap.sink { [weak self] _ in
            self?.coordinator?.showCreateFolderViewController()
        }
        .store(in: &anyCancellable)
        
        input.deleteButtonTap.sink { [weak self] _ in
            print("ㅋㅋ")
        }
        .store(in: &anyCancellable)
        return Output()
    }
}
