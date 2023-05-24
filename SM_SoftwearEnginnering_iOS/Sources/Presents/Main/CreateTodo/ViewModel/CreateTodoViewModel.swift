//
//  CreateTodoViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine

final class CreateTodoViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private var anyCancellable = Set<AnyCancellable>()
    private let createTodoUseCase: CreateTodoUseCase


    init(coordinator: MainCoordinator?, createTodoUseCase: CreateTodoUseCase) {
        self.coordinator = coordinator
        self.createTodoUseCase = createTodoUseCase
    }
    
    var todoTitleText = CurrentValueSubject<String, Never>("무제")
    var folderListPublish = CurrentValueSubject<[Folder], Never>([])
    var folderColor = CurrentValueSubject<String, Never>("RED")

    struct Input {
        let createTodoButtonTap: AnyPublisher<Void, Never>
        let todoTitleText: AnyPublisher<String, Never>
        let redButtonTap: AnyPublisher<Void, Never>
        let greenButtonTap: AnyPublisher<Void, Never>
        let yellowButtonTap: AnyPublisher<Void, Never>
        let orangeButtonTap: AnyPublisher<Void, Never>
        let purpleButtonTap: AnyPublisher<Void, Never>
    }

    struct Output {

    }
    
    func transform(_ input: Input) -> Output {
        
        input.createTodoButtonTap
            .map {
                self.createTodoUseCase
                    .excute(title: "string", content: "string", priority: Int32(1), wishCompleteDate: "2023-05-23", folderId: Int64(1), memberId: Int64(1))
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] statusCode in
                print(statusCode, "post statuscode")
            }
            .store(in: &anyCancellable)
        
        input.todoTitleText
            .sink { [weak self] folderTitleText in
                self?.todoTitleText.value = folderTitleText
            }
            .store(in: &anyCancellable)
        
        input.greenButtonTap.sink { [weak self] _ in
            self?.folderColor.send("GREEN")
        }
        .store(in: &anyCancellable)
        
        input.orangeButtonTap.sink { [weak self] _ in
            self?.folderColor.send("ORANGE")
        }
        .store(in: &anyCancellable)

        input.purpleButtonTap.sink { [weak self] _ in
            self?.folderColor.send("PURPLE")
        }
        .store(in: &anyCancellable)
        
        input.redButtonTap.sink { [weak self] _ in
            self?.folderColor.send("RED")
        }
        .store(in: &anyCancellable)
        
        input.yellowButtonTap.sink { [weak self] _ in
            self?.folderColor.send("YELLOW")
        }
        .store(in: &anyCancellable)
        
        return Output()
    }
}

