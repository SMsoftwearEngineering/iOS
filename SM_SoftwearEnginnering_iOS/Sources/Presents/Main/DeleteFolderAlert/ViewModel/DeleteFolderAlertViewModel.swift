//
//  DeleteFolderAlertViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine
import RealmSwift

final class DeleteFolderAlertViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private var anyCancellable = Set<AnyCancellable>()
    private var folderUseCase: FolderUseCase
    private var folder: CurrentValueSubject<Folder, Never>


    init(coordinator: MainCoordinator?, folderUseCase: FolderUseCase, folder: Folder) {
        self.coordinator = coordinator
        self.folderUseCase = folderUseCase
        self.folder = CurrentValueSubject(folder)
    }
    
    struct Input {
        let okButtonTap: AnyPublisher<Void, Never>
        let noButtonTap: AnyPublisher<Void, Never>
    }

    struct Output {

    }
    
    func transform(_ input: Input) -> Output {
        input.okButtonTap.sink { [weak self] _ in
            self?.deleteFolder(folder: self?.folder.value ?? Folder(folderId: ObjectId(), color: "", folderTitle: "", memberId: 0))
            self?.coordinator?.dismissViewController()
        }
        .store(in: &anyCancellable)
        
        input.noButtonTap.sink { [weak self] _ in
            self?.coordinator?.dismissViewController()
        }
        .store(in: &anyCancellable)
        return Output()
    }
}

extension DeleteFolderAlertViewModel {
    func deleteFolder(folder: Folder) {
        folderUseCase.delete(memberId: folder.memberId, folderId: folder.folderId)
    }
}
