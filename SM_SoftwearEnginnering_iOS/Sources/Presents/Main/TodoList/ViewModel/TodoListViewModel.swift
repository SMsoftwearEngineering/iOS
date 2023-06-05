//
//  TodoListViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine
import RealmSwift

final class TodoListViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private var anyCancellable = Set<AnyCancellable>()
    private var folderSubject: CurrentValueSubject<Folder, Never>

    init(coordinator: MainCoordinator?, folder: Folder) {
        self.coordinator = coordinator
        self.folderSubject = CurrentValueSubject(folder)
    }

    struct Input {
        let todoCreateButtonTap: AnyPublisher<Void, Never>
        let filterButtonTap: AnyPublisher<Void, Never>
        let backButtonTap: AnyPublisher<Void, Never>
        let deleteButtonTap: AnyPublisher<Void, Never>
        let cellButtonTap: AnyPublisher<Void, Never>
        let viewDidLoad: AnyPublisher<Void, Never>
    }

    struct Output {
        let folderPublish: AnyPublisher<Folder, Never>
    }

    func transform(_ input: Input) -> Output {
        input.viewDidLoad.sink { _ in
            print("viewDidLoad")
            print(self.folderSubject.value.folderId, "folderId")
        }
        .store(in: &anyCancellable)

        input.backButtonTap.sink { [weak self] _ in
            self?.coordinator?.popViewController()
        }
        .store(in: &anyCancellable)

        input.todoCreateButtonTap.sink { [weak self] _ in
            self?.coordinator?.showCreateTodoViewController()
        }
        .store(in: &anyCancellable)

        input.cellButtonTap.sink { [weak self] _ in
            self?.coordinator?.showDetailTodoViewController()
        }
        .store(in: &anyCancellable)

        let folderPublish = folderSubject.eraseToAnyPublisher()
        return Output(folderPublish: folderPublish)
    }
}
