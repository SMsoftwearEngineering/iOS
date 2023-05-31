//
//  CreateFolderViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine

final class CreateFolderViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private var anyCancellable = Set<AnyCancellable>()
    private let createFolderUseCase: CreateFolderUseCase

    init(coordinator: MainCoordinator?, createFolderUseCase: CreateFolderUseCase) {
        self.coordinator = coordinator
        self.createFolderUseCase = createFolderUseCase
    }
    
    var folderTitleText = CurrentValueSubject<String, Never>("무제")
    var folderListPublish = CurrentValueSubject<Folder, Never>(Folder(folderId: Int64(0), color: "RED", folderTitle: "", memberId: 0, todo: [Todo(todoId: Int64(0), title: "", content: "", completeDate: Date(), priority: Int32(0), wishCompleteDate: Date(), folderId: Int64(0), memberId: 0, done: false)]))
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
            .map {
                self.createFolderUseCase.excute(folderTitle: self.folderTitleText.value, memberId: UserDefaults.standard.string(forKey: "memberId") ?? "0", color: self.folderColor.value)
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] folder in
                print(folder)
                self?.folderListPublish.send(folder)
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

