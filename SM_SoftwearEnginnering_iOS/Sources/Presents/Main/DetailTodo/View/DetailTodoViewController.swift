//
//  DetailTodoViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit

final class DetailTodoViewController: BaseViewController {
    
    private let selfView = DetailTodoView()
    
    private let viewModel: DetailTodoViewModel
    
    init(viewModel: DetailTodoViewModel) {
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
        let input = DetailTodoViewModel.Input(cancelButtonTap: selfView.cancelButton.tapPublisher)
        let output = viewModel.transform(input)
    }
}
