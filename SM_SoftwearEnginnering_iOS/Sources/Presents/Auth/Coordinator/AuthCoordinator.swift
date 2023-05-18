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
        showSignupViewController()
    }
    
    func showSignupViewController() {
        let viewModel = SignupViewModel(coordinator: self)
        let vc = SignupViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
}
