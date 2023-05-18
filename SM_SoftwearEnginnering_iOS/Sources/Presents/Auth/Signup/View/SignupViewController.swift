//
//  SignupViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit

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
}
