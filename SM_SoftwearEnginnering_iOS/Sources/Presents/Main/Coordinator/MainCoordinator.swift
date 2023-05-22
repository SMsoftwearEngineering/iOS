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
        let viewModel = HomeViewModel(coordinator: self)
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
}
