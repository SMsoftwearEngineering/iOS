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
        let cellButtonTap: AnyPublisher<Void, Never>
        let viewDidLoad: AnyPublisher<Void, Never>

    }

    struct Output {

    }
    
    func transform(_ input: Input) -> Output {
        input.viewDidLoad.sink { _ in
            print("viewDidLoad")
        }
        .store(in: &anyCancellable)
        
        input.logoutButtonTap.sink { [weak self] _ in
//            self?.coordinator?.showDetailTodoViewController()
            self?.coordinator?.connectAuthCoordinator()
        }
        .store(in: &anyCancellable)
        
        input.folderCreateButtonTap.sink { [weak self] _ in
            self?.coordinator?.showCreateFolderViewController()
        }
        .store(in: &anyCancellable)
        
        input.deleteButtonTap.sink { [weak self] _ in
            self?.coordinator?.showDeleteFolderAlertViewController()
        }
        .store(in: &anyCancellable)
        
        input.cellButtonTap
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
            self?.coordinator?.showTodoListViewController()
        }
        .store(in: &anyCancellable)

        return Output()
    }
}
