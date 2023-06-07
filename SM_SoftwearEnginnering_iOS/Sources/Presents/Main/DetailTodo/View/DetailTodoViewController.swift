//
//  DetailTodoViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit
import Combine

final class DetailTodoViewController: BaseViewController {
    
    private let selfView = DetailTodoView()
    
    private let viewModel: DetailTodoViewModel
    
    private var anyCancellable = Set<AnyCancellable>()
    
    let dateFormatter = DateFormatter()
    
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
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
    }
    
    override func setAttributes() {
        selfView.backgroundColor = .clear
    }
    
    override func setBinding() {
        let input = DetailTodoViewModel.Input(cancelButtonTap: selfView.cancelButton.tapPublisher)
        let output = viewModel.transform(input)
        output.todoPublish.sink { todo in
            print(todo, "todo")
            self.selfView.titleLabel.text = todo.title
            self.selfView.contentLabel.text = todo.content
            self.selfView.createDateLabel.text = self.dateFormatter.string(from: todo.completeDate)
            self.selfView.finishDateLabel.text = self.dateFormatter.string(from: todo.wishCompleteDate)
            print("♻️♻️♻️♻️",self.dateFormatter.string(from: Date()))
        }
        .store(in: &anyCancellable)
    }
}
