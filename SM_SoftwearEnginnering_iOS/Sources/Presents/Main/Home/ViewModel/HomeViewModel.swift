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
    private let getFolderListUseCase: GetFolderListUseCase
    private let testUseCase: TestUseCase


    init(coordinator: MainCoordinator?, getFolderListUseCase: GetFolderListUseCase, testUseCase: TestUseCase) {
        self.coordinator = coordinator
        self.getFolderListUseCase = getFolderListUseCase
        self.testUseCase = testUseCase
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
    
    var folderListPublish = CurrentValueSubject<[Folder], Never>([])

    
    func transform(_ input: Input) -> Output {
//        input.viewDidLoad
//            .map {
//                self.getFolderListUseCase.excute()
//            }
//            .switchToLatest()
//            .receive(on: DispatchQueue.main)
//            .sink { error in
//                print(error)
//            } receiveValue: { [weak self] folder in
//                print(folder)
//                self?.folderListPublish.send(folder)
//            }
//            .store(in: &anyCancellable)
        
        input.viewDidLoad
            .map {
                self.testUseCase.excute(memberId: Int64(UserDefaults.standard.integer(forKey: "memberId")))
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] folder in
                print(folder)
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
