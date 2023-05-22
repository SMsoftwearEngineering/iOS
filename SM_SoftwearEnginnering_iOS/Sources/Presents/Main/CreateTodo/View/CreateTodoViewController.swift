//
//  CreateTodoViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit

final class CreateTodoViewController: BaseViewController {
    private let selfView = CreateTodoView()
    
    private let viewModel: CreateTodoViewModel
    
    init(viewModel: CreateTodoViewModel) {
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
        let input = CreateTodoViewModel.Input(createTodoButtonTap: selfView.createButton.tapPublisher, todoTitleText: selfView.todoNameTextField.tf.textPublisher, redButtonTap: selfView.redButton.tapPublisher, greenButtonTap: selfView.greenButton.tapPublisher, yellowButtonTap: selfView.yellowButton.tapPublisher, orangeButtonTap: selfView.orangeButton.tapPublisher, purpleButtonTap: selfView.purpleButton.tapPublisher)
        
        
        let output = viewModel.transform(input)
    }
}
