//
//  CreateFolderViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit
import Toast

final class CreateFolderViewController: BaseViewController {
    private let selfView = CreateFolderView()
    
    private let viewModel: CreateFolderViewModel
    
    init(viewModel: CreateFolderViewModel) {
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
        let input = CreateFolderViewModel.Input(createFolderButtonTap: selfView.createButton.tapPublisher, folderTitleText: selfView.folderNameTextField.tf.textPublisher, redButtonTap: selfView.redButton.tapPublisher, greenButtonTap: selfView.greenButton.tapPublisher, yellowButtonTap: selfView.yellowButton.tapPublisher, orangeButtonTap: selfView.orangeButton.tapPublisher, purpleButtonTap: selfView.purpleButton.tapPublisher)
        
        
        let output = viewModel.transform(input)
        output.toastMessage.sink(receiveValue: { [unowned self] text in
            self.view.makeToast(text, position: .bottom)
        })
        .store(in: &cancellableBag)
    }
}
