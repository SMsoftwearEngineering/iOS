//
//  CreateFolderViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine
import RealmSwift

final class CreateFolderViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private var anyCancellable = Set<AnyCancellable>()
    private let folderUseCase: FolderUseCase

    init(coordinator: MainCoordinator?, folderUseCase: FolderUseCase) {
        self.coordinator = coordinator
        self.folderUseCase = folderUseCase
    }
    
    var folderTitleText = CurrentValueSubject<String, Never>("무제")
    var folderListPublish = CurrentValueSubject<Folder, Never>(Folder(folderId: ObjectId(), color: "RED", folderTitle: "", memberId: 0))
    var folderColor = CurrentValueSubject<String, Never>("PURPLE")

    struct Input {
        let createFolderButtonTap: AnyPublisher<Void, Never>
        let folderTitleText: AnyPublisher<String, Never>
        let redButtonTap: AnyPublisher<Void, Never>
        let greenButtonTap: AnyPublisher<Void, Never>
        let yellowButtonTap: AnyPublisher<Void, Never>
        let orangeButtonTap: AnyPublisher<Void, Never>
        let purpleButtonTap: AnyPublisher<Void, Never>
    }

    struct Output {
        let toastMessage: AnyPublisher<String, Never>
    }
    
    var toastMessage = CurrentValueSubject<String, Never>("")
    
    func transform(_ input: Input) -> Output {

        input.createFolderButtonTap
            .sink { [weak self] _ in
                self?.addFolder(folder: Folder(folderId: ObjectId(), color: self?.folderColor.value ?? "", folderTitle: self?.folderTitleText.value ?? "", memberId: UserDefaults.standard.integer(forKey: "memberId")))
                self?.coordinator?.popViewController()
                print("✅✅✅",Realm.Configuration.defaultConfiguration.fileURL!)

            }
            .store(in: &anyCancellable)
        
        input.folderTitleText
            .sink { [weak self] folderTitleText in
                self?.folderTitleText.value = folderTitleText
            }
            .store(in: &anyCancellable)
        
        input.greenButtonTap.sink { [weak self] _ in
            self?.folderColor.send("GREEN")
            self?.toastMessage.send("초록색을 선택하셨습니다.")
        }
        .store(in: &anyCancellable)
        
        input.orangeButtonTap.sink { [weak self] _ in
            self?.folderColor.send("ORANGE")
            self?.toastMessage.send("주황색을 선택하셨습니다.")
        }
        .store(in: &anyCancellable)

        input.purpleButtonTap.sink { [weak self] _ in
            self?.folderColor.send("PURPLE")
            self?.toastMessage.send("보라색을 선택하셨습니다.")
        }
        .store(in: &anyCancellable)
        
        input.redButtonTap.sink { [weak self] _ in
            self?.folderColor.send("RED")
            self?.toastMessage.send("빨간색을 선택하셨습니다.")
        }
        .store(in: &anyCancellable)
        
        input.yellowButtonTap.sink { [weak self] _ in
            self?.folderColor.send("YELLOW")
            self?.toastMessage.send("노란색을 선택하셨습니다.")
        }
        .store(in: &anyCancellable)
        
        let toastMessage = self.toastMessage.eraseToAnyPublisher()
        
        return Output(toastMessage: toastMessage)
    }
}

extension CreateFolderViewModel {
    func addFolder(folder: Folder) {
        folderUseCase.create(with: folder)
    }
    
    func fetchFolder(memberId: Int) -> [Folder?] {
        folderUseCase.load(memberId: memberId)
    }
}
