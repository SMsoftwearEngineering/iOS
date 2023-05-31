//
//  MainCoordinator.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import UIKit

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
        let getFolderListRepositroyImpl = GetFolderListRepositroyImpl(session: session)
        let getFolderListUseCaseImpl = GetFolderListUseCaseImpl(getFolderListRepository: getFolderListRepositroyImpl)
        let testRepositroyImpl = TestRepositoryImpl(session: session)
        let testUseCaseImpl = TestUseCaseImpl(testRepository: testRepositroyImpl)
        let viewModel = HomeViewModel(coordinator: self, getFolderListUseCase: getFolderListUseCaseImpl, testUseCase: testUseCaseImpl)
        let vc = HomeViewController(viewModel: viewModel)
        changeAnimation()
        navigationController.viewControllers = [vc]
    }
    
    func showCreateFolderViewController() {
        let session = ServiceImpl.shared
        let createFolderRepositroyImpl = CreateFolderRepositoryImpl(session: session)
        let createFolderUseCaseImpl = CreateFolderUseCaseImpl(createFolderRepository: createFolderRepositroyImpl)
        let viewModel = CreateFolderViewModel(coordinator: self, createFolderUseCase: createFolderUseCaseImpl)
        let vc = CreateFolderViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showCreateTodoViewController() {
        let session = ServiceImpl.shared
        let createTodoRepositroyImpl = CreateTodoRepositoryImpl(session: session)
        let createTodoUseCaseImpl = CreateTodoUseCaseImpl(createTodoRepository: createTodoRepositroyImpl)
        let viewModel = CreateTodoViewModel(coordinator: self, createTodoUseCase: createTodoUseCaseImpl)
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
    
    func showDetailTodoViewController() {
        let viewModel = DetailTodoViewModel(coordinator: self)
        let vc = DetailTodoViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func showTodoListViewController() {
        let viewModel = TodoListViewModel(coordinator: self)
        let vc = TodoListViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)

    }
    
    func connectAuthCoordinator() {
        let authCoordinator = AuthCoordinator(self.navigationController)
        authCoordinator.start()
        childCoordinators.append(authCoordinator)
    }
}
