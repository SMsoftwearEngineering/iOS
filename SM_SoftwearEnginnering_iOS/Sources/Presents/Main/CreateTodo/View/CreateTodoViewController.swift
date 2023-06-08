//
//  CreateTodoViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit
import Toast

final class CreateTodoViewController: BaseViewController, UITextFieldDelegate {
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
        let datePicker = UIDatePicker()
        let datePicker2 = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker2.datePickerMode = .date

        self.selfView.createDateTextField.tf.inputView = datePicker
        self.selfView.finishDateTextField.tf.inputView = datePicker2

        self.selfView.createDateTextField.tf.delegate = self
        self.selfView.finishDateTextField.tf.delegate = self

        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        datePicker2.addTarget(self, action: #selector(datePickerValueChanged2(_:)), for: .valueChanged)
    }
    
    override func setBinding() {
        let input = CreateTodoViewModel.Input(createTodoButtonTap: selfView.createButton.tapPublisher, todoTitleText: selfView.todoNameTextField.tf.textPublisher, todoContentText: selfView.contentTextField.textPublisher, redButtonTap: selfView.redButton.tapPublisher, greenButtonTap: selfView.greenButton.tapPublisher, yellowButtonTap: selfView.yellowButton.tapPublisher, orangeButtonTap: selfView.orangeButton.tapPublisher, purpleButtonTap: selfView.purpleButton.tapPublisher, startDate: selfView.createDateTextField.tf.textPublisher, finishDate: selfView.finishDateTextField.tf.textPublisher)
        
        
        let output = viewModel.transform(input)
        
        output.toastMessage.sink(receiveValue: { [unowned self] text in
            self.view.makeToast(text, position: .bottom)
        })
        .store(in: &cancellableBag)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.selfView.createDateTextField.tf.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func datePickerValueChanged2(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.selfView.finishDateTextField.tf.text = dateFormatter.string(from: sender.date)
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.selfView.createDateTextField.tf {
            textField.inputView?.isHidden = false
        } else if textField == self.selfView.finishDateTextField.tf {
            textField.inputView?.isHidden = false
        }
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.selfView.createDateTextField.tf {
            textField.inputView?.isHidden = true
        } else if textField == self.selfView.finishDateTextField.tf {
            textField.inputView?.isHidden = false
        }
        return true
    }
}
