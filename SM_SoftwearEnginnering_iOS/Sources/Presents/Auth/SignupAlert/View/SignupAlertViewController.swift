//
//  SignupAlertViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit

final class SignupAlertViewController: BaseViewController {
    
    private let selfView = CustomAlertView(text: "이미 가입된 회원입니다.")
    
    private let viewModel: SignupAlertViewModel
    
    init(viewModel: SignupAlertViewModel) {
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
    
    override func setAttributes() {
        navigationController?.isNavigationBarHidden = true
        selfView.backgroundColor = .clear
    }
    
    override func setBinding() {
        let input = SignupAlertViewModel.Input(okButtonTap: selfView.okButton.tapPublisher)
        let output = viewModel.transform(input)
    }
}
