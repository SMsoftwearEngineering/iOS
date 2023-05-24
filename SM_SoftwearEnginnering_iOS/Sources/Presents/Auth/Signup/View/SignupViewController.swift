//
//  SignupViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit
import Combine
import Toast

final class SignupViewController: BaseViewController {
    
    private let selfView = SignupView()
    
    private let viewModel: SignupViewModel
    
    init(viewModel: SignupViewModel) {
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
        navigationController?.isNavigationBarHidden = false
    }
    
    override func setBinding() {
        let input = SignupViewModel.Input(idText: selfView.idTextField.tf.textPublisher, pwText: selfView.pwTextField.tf.textPublisher, confirmPwText: selfView.confirmTextField.tf.textPublisher, signUpButtonTap: selfView.signupButton.tapPublisher)
        let output = viewModel.transform(input)
        
        output.signUpValid.sink { valid in
            self.selfView.signupButton.isEnabled = valid
            
        }
        .store(in: &cancellableBag)
        
        output.toastMessage.sink(receiveValue: { [unowned self] text in
            self.view.makeToast(text, position: .bottom)
        })
        .store(in: &cancellableBag)
    }
}
