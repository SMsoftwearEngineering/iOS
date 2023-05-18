//
//  LoginViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit

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
}
