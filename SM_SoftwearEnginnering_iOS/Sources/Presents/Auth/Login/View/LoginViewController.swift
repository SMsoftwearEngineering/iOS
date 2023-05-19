//
//  LoginViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit
import Combine

final class LoginViewController: BaseViewController {
    
    private let selfView = LoginView()
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let registerQuery = RegisterQuery(email: "qudgus1984", name: "이병현", password: "qwer1234!")
        let registerTarget = Test.register(parameters: registerQuery)
        registerTarget.request { result in
            switch result {
            case .success(let statusCode):
                print("성공", statusCode)
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    override func setBinding() {
        
        let input = LoginViewModel.Input(signupButtonTap: selfView.signupButton.tapPublisher, loginButtonTap: selfView.loginButton.tapPublisher)
        let output = viewModel.transform(input)
    }
}
