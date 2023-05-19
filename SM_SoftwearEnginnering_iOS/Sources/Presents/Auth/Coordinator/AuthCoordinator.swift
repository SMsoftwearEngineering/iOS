//
//  AuthCoordinator.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit

final class AuthCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .auth
    
    private let userDefaults = UserDefaults.standard
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {

        showLoginViewController()
    }
    
    func showSignupViewController() {
        let viewModel = SignupViewModel(coordinator: self)
        let vc = SignupViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showLoginViewController() {
        let session = ServiceImpl.shared
        let registerRepositroyImpl = RegisterRepositoryImpl(session: session)
        let registerUseCaseImpl = RegisterUseCaseImpl(registerRepository: registerRepositroyImpl)
        let viewModel = LoginViewModel(registerUseCase: registerUseCaseImpl, coordinator: self)
        let vc = LoginViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }

    func showSignupAlertViewController() {
        let viewModel = SignupAlertViewModel(coordinator: self)
        let vc = SignupAlertViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func popPopupViewController() {
        navigationController.dismiss(animated: true)
    }
}
