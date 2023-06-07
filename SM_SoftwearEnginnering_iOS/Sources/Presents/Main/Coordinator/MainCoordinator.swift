//
//  MainCoordinator.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import UIKit
import RealmSwift

final class MainCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .main
    
    private let userDefaults = UserDefaults.standard
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {

        showHomeViewController()
    }
    
    func showHomeViewController() {
        let session = ServiceImpl.shared


        let testRepositroyImpl = TestRepositoryImpl(session: session)
        let testUseCaseImpl = TestUseCaseImpl(testRepository: testRepositroyImpl)
        let postTestRepositroyImpl = PostTestRepositoryImpl(session: session)
        let postTestUseCaseImpl = PostTestUseCaseImpl(postTestRepository: postTestRepositroyImpl)
        let folderRepositoryImpl = FolderRealmRepositoryImpl()
        let folderUseCaseImpl = FolderUseCaseImpl(folderRealmRepository: folderRepositoryImpl)
        let viewModel = HomeViewModel(coordinator: self, testUseCase: testUseCaseImpl, postTestUseCase: postTestUseCaseImpl, folderUseCase: folderUseCaseImpl)
        let vc = HomeViewController(viewModel: viewModel)
        changeAnimation()
        navigationController.viewControllers = [vc]
    }
    
    func showCreateFolderViewController() {
        let session = ServiceImpl.shared
        let createFolderRepositroyImpl = CreateFolderRepositoryImpl(session: session)
        let folderRepositoryImpl = FolderRealmRepositoryImpl()
        let folderUseCaseImpl = FolderUseCaseImpl(folderRealmRepository: folderRepositoryImpl)
        let viewModel = CreateFolderViewModel(coordinator: self, folderUseCase: folderUseCaseImpl)
        let vc = CreateFolderViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCreateTodoViewController(folderId: ObjectId) {
        let session = ServiceImpl.shared
        let createTodoRepositroyImpl = CreateTodoRepositoryImpl(session: session)
        let createTodoUseCaseImpl = CreateTodoUseCaseImpl(createTodoRepository: createTodoRepositroyImpl)
        let todoRepositoryImpl = TodoRealmRepositoryImpl()
        let todoUseCaseImpl = TodoUseCaseImpl(todoRealmRepository: todoRepositoryImpl)
        let viewModel = CreateTodoViewModel(coordinator: self, createTodoUseCase: createTodoUseCaseImpl, todoUseCase: todoUseCaseImpl, folderId: folderId)
        let vc = CreateTodoViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func showDeleteFolderAlertViewController() {
        let viewModel = DeleteFolderAlertViewModel(coordinator: self)
        let vc = DeleteFolderAlertViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func showDetailTodoViewController(todo: Todo) {
        let viewModel = DetailTodoViewModel(coordinator: self, todo: todo)
        let vc = DetailTodoViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func showTodoListViewController(folder: Folder) {
        let todoRepositoryImpl = TodoRealmRepositoryImpl()
        let todoUseCaseImpl = TodoUseCaseImpl(todoRealmRepository: todoRepositoryImpl)
        let viewModel = TodoListViewModel(coordinator: self, folder: folder, todoUseCase: todoUseCaseImpl)
        let vc = TodoListViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)

    }
    
    func connectAuthCoordinator() {
        let authCoordinator = AuthCoordinator(self.navigationController)
        authCoordinator.start()
        childCoordinators.append(authCoordinator)
    }
}
