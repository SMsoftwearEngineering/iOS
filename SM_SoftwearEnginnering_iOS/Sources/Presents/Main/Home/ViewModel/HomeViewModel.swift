//
//  HomeViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation
import Combine
import RealmSwift

final class HomeViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private var anyCancellable = Set<AnyCancellable>()
//    private let getFolderListUseCase: GetFolderListUseCase
    private let testUseCase: TestUseCase
    private let postTestUseCase: PostTestUseCase
    private let folderUseCase: FolderUseCase


    init(coordinator: MainCoordinator?, testUseCase: TestUseCase, postTestUseCase: PostTestUseCase, folderUseCase: FolderUseCase) {
        self.coordinator = coordinator
        self.testUseCase = testUseCase
        self.postTestUseCase = postTestUseCase
        self.folderUseCase = folderUseCase
    }
    
    struct Input {
        let logoutButtonTap: AnyPublisher<Void, Never>
        let folderCreateButtonTap: AnyPublisher<Void, Never>
        let filterButtonTap: AnyPublisher<Void, Never>
        let finishTaskListButtonTap: AnyPublisher<Void, Never>
        let deleteButtonTap: AnyPublisher<Void, Never>
        let cellButtonTap: AnyPublisher<Void, Never>
        let viewDidLoad: AnyPublisher<Void, Never>
        let folder: AnyPublisher<Folder, Never>
    }

    struct Output {
        let folderListPublish: AnyPublisher<[Folder?]?, Never>
    }
    
    var folderListPublish = CurrentValueSubject<[Folder?]?, Never>([])
    var folder = CurrentValueSubject<Folder, Never>(Folder(folderId: ObjectId(), color: "RED", folderTitle: "", memberId: 0))

    
    func transform(_ input: Input) -> Output {
        
//        input.viewDidLoad
//            .map {
//                self.testUseCase.excute(memberId: Int64(UserDefaults.standard.string(forKey: "memberId") ?? "0") ?? 0)
//            }
//            .switchToLatest()
//            .receive(on: DispatchQueue.main)
//            .sink { error in
//                print(error)
//            } receiveValue: { [weak self] folder in
//                print(folder)
//            }
//            .store(in: &anyCancellable)
        
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
        
        input.folder.sink { folder in
            self.folder.send(folder)
        }
        .store(in: &anyCancellable)
        input.cellButtonTap
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.coordinator?.showTodoListViewController(folder: self?.folder.value ?? Folder(folderId: ObjectId(), color: "RED", folderTitle: "", memberId: 0))
        }
        .store(in: &anyCancellable)
        
        input.viewDidLoad
            .sink { [weak self] _ in
                self?.folderListPublish.send(self?.fetchFolder(memberId: UserDefaults.standard.integer(forKey: "memberId")))
            }
            .store(in: &anyCancellable)
        
        let folderListPublish = self.folderListPublish.eraseToAnyPublisher()

        return Output(folderListPublish: folderListPublish)
    }
}

//MARK: Realm 관련 로직
extension HomeViewModel {
    func addFolder(folder: Folder) {
        folderUseCase.create(with: folder)
    }
    
    func fetchFolder(memberId: Int) -> [Folder?] {
        folderUseCase.load(memberId: memberId)
    }
}
