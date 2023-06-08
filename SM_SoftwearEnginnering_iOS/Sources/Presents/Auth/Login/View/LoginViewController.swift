//
//  LoginViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit
import Combine
import Toast

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
    }
    
    override func setBinding() {
        
        let input = LoginViewModel.Input(signupButtonTap: selfView.signupButton.tapPublisher, loginButtonTap: selfView.loginButton.tapPublisher, idText: selfView.idTextField.tf.textPublisher, pwText: selfView.pwTextField.tf.textPublisher)
        let output = viewModel.transform(input)
        
        output.toastMessage.sink { [unowned self] text in
            self.view.makeToast(text, position: .bottom)
        }
        .store(in: &cancellableBag)
    }
}
