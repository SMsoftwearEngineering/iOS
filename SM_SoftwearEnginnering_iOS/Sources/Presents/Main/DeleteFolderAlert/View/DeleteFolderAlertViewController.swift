//
//  DeleteFolderAlertViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit

final class DeleteFolderAlertViewController: BaseViewController {
    
    private let selfView = CustomYesOrNoAlertView(text: "작업 폴더 및 내부의 작업들을 모두 삭제하시겠습니까?")
    
    private let viewModel: DeleteFolderAlertViewModel
    
    init(viewModel: DeleteFolderAlertViewModel) {
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
        let input = DeleteFolderAlertViewModel.Input(okButtonTap: selfView.okButton.tapPublisher, noButtonTap: selfView.noButton.tapPublisher)
        let output = viewModel.transform(input)
    }
}
