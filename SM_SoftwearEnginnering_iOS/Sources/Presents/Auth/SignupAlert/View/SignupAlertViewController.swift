//
//  SignupAlertViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit

final class SignupAlertViewController: BaseViewController {
    
    private let selfView = SignupAlertView()
    
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
}
