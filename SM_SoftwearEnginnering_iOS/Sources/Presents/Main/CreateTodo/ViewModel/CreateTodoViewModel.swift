//
//  CreateTodoViewModel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine
import RealmSwift

final class CreateTodoViewModel: ViewModelType {
    private weak var coordinator: MainCoordinator?
    private var anyCancellable = Set<AnyCancellable>()
    private let createTodoUseCase: CreateTodoUseCase
    private let todoUseCase: TodoUseCase
    private var folderId: CurrentValueSubject<ObjectId, Never>

    init(coordinator: MainCoordinator?, createTodoUseCase: CreateTodoUseCase, todoUseCase: TodoUseCase, folderId: ObjectId) {
        self.coordinator = coordinator
        self.createTodoUseCase = createTodoUseCase
        self.todoUseCase = todoUseCase
        self.folderId = CurrentValueSubject(folderId)
    }
    
    struct Input {
        let createTodoButtonTap: AnyPublisher<Void, Never>
        let todoTitleText: AnyPublisher<String, Never>
        let todoContentText: AnyPublisher<String, Never>
        let redButtonTap: AnyPublisher<Void, Never>
        let greenButtonTap: AnyPublisher<Void, Never>
        let yellowButtonTap: AnyPublisher<Void, Never>
        let orangeButtonTap: AnyPublisher<Void, Never>
        let purpleButtonTap: AnyPublisher<Void, Never>
    }

    struct Output {
        let toastMessage: AnyPublisher<String, Never>
    }
    
    var todoTitleText = CurrentValueSubject<String, Never>("무제")
    var todoContentText = CurrentValueSubject<String, Never>("")
    var folderListPublish = CurrentValueSubject<[Folder], Never>([])
    var folderColor = CurrentValueSubject<String, Never>("RED")
    
    var toastMessage = CurrentValueSubject<String, Never>("")
    
    func transform(_ input: Input) -> Output {
        
//        input.createTodoButtonTap
//            .map {
//                self.createTodoUseCase
//                    .excute(title: "string", content: "string", priority: Int32(1), wishCompleteDate: "2023-05-23", folderId: Int64(1), memberId: Int64(1))
//            }
//            .switchToLatest()
//            .receive(on: DispatchQueue.main)
//            .sink { error in
//                print(error)
//            } receiveValue: { [weak self] statusCode in
//                print(statusCode, "post statuscode")
//            }
//            .store(in: &anyCancellable)
        
        input.createTodoButtonTap
            .sink { [weak self] _ in
                self?.addTodo(todo: Todo(todoId: ObjectId(), title: self?.todoTitleText.value ?? "", content: self?.todoContentText.value ?? "", completeDate: Date() - 86400, priority: 1, wishCompleteDate: Date(), folderId: self?.folderId.value ?? ObjectId(), memberId: UserDefaults.standard.integer(forKey: "memberId"), done: false, color: self?.folderColor.value ?? ""))
                self?.coordinator?.popViewController()
            }
            .store(in: &anyCancellable)
        
        input.todoTitleText
            .sink { [weak self] todoTitleText in
                self?.todoTitleText.value = todoTitleText
            }
            .store(in: &anyCancellable)
        
        input.todoContentText
            .sink { [weak self] todoContentText in
                self?.todoContentText.value = todoContentText
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

extension CreateTodoViewModel {
    func addTodo(todo: Todo) {
        todoUseCase.create(with: todo)
    }
}
