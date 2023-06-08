//
//  DeleteTodoAlertViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/08.
//

import UIKit

final class DeleteTodoAlertViewController: BaseViewController {
    
    private let selfView = CustomYesOrNoAlertView(text: "Todo를 삭제하시겠습니까?")
    
    private let viewModel: DeleteTodoAlertViewModel
    
    init(viewModel: DeleteTodoAlertViewModel) {
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
        let input = DeleteTodoAlertViewModel.Input(okButtonTap: selfView.okButton.tapPublisher, noButtonTap: selfView.noButton.tapPublisher)
        let output = viewModel.transform(input)
    }
}
