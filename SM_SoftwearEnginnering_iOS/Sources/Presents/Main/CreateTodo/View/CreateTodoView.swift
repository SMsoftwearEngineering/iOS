//
//  CreateTodoView.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit
import SnapKit

final class CreateTodoView: BaseView {
    let todoNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()
    
    let todoNameTextField: CustomTextFieldView = {
        let tf = CustomTextFieldView(placeholder: "Todo 이름")
        return tf
    }()
    
    let createDateLabel: UILabel = {
        let label = UILabel()
        label.text = "createDate"
        return label
    }()
    
    let createDateTextField: CustomTextFieldView = {
        let tf = CustomTextFieldView(placeholder: "시작 날짜")
        return tf
    }()
    
    let finishDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Deadline"
        return label
    }()
    
    let finishDateTextField: CustomTextFieldView = {
        let tf = CustomTextFieldView(placeholder: "끝나는 날짜")
        return tf
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "Contents"
        return label
    }()
        
    let contentTextField: UITextView = {
        let tf = UITextView()
        tf.layer.cornerRadius = 8
        tf.layer.borderColor = UIColor.SMPurple.cgColor
        tf.layer.borderWidth = 2
        return tf
    }()
    
    let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Color"
        return label
    }()
    
    let redButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .SMRed
        button.layer.cornerRadius = 2
        return button
    }()
    
    let greenButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .SMGreen
        button.layer.cornerRadius = 2
        return button
    }()
    
    let yellowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .SMYellow
        button.layer.cornerRadius = 2
        return button
    }()
    
    let purpleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .SMPurple
        button.layer.cornerRadius = 2
        return button
    }()
    
    let orangeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .SMOrange
        button.layer.cornerRadius = 2
        return button
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.backgroundColor = .SMPurple
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func setHierarchy() {
        self.addSubview(todoNameLabel)
        self.addSubview(todoNameTextField)
        self.addSubview(createDateLabel)
        self.addSubview(createDateTextField)
        self.addSubview(finishDateLabel)
        self.addSubview(finishDateTextField)
        self.addSubview(contentLabel)
        self.addSubview(contentTextField)
        self.addSubview(greenButton)
        self.addSubview(redButton)
        self.addSubview(yellowButton)
        self.addSubview(purpleButton)
        self.addSubview(orangeButton)
        self.addSubview(colorLabel)
        self.addSubview(createButton)

    }
    
    override func setLayout() {
        todoNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(68)
            make.height.equalTo(12)
        }
        
        todoNameTextField.snp.makeConstraints { make in
            make.top.equalTo(todoNameLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(64)
            make.height.equalTo(32)
        }
        
        createDateLabel.snp.makeConstraints { make in
            make.top.equalTo(todoNameTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(68)
            make.height.equalTo(12)
        }
        
        createDateTextField.snp.makeConstraints { make in
            make.top.equalTo(createDateLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(64)
            make.height.equalTo(32)
        }
        
        finishDateLabel.snp.makeConstraints { make in
            make.top.equalTo(createDateTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(68)
            make.height.equalTo(12)
        }
        
        finishDateTextField.snp.makeConstraints { make in
            make.top.equalTo(finishDateLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(64)
            make.height.equalTo(32)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(finishDateTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(68)
            make.height.equalTo(12)
        }
        
        contentTextField.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(64)
            make.height.equalTo(200)
        }
        
        greenButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentTextField.snp.bottom).offset(40)
            make.height.width.equalTo(28)
        }
        
        yellowButton.snp.makeConstraints { make in
            make.verticalEdges.width.height.equalTo(greenButton)
            make.trailing.equalTo(greenButton.snp.leading).offset(-8)
        }
        
        purpleButton.snp.makeConstraints { make in
            make.verticalEdges.width.height.equalTo(greenButton)
            make.leading.equalTo(greenButton.snp.trailing).offset(8)
        }
        
        redButton.snp.makeConstraints { make in
            make.verticalEdges.width.height.equalTo(greenButton)
            make.trailing.equalTo(yellowButton.snp.leading).offset(-8)
        }
        
        orangeButton.snp.makeConstraints { make in
            make.verticalEdges.width.height.equalTo(greenButton)
            make.leading.equalTo(purpleButton.snp.trailing).offset(8)
        }
        
        colorLabel.snp.makeConstraints { make in
            make.leading.equalTo(redButton.snp.leading)
            make.trailing.equalTo(orangeButton.snp.trailing)
            make.bottom.equalTo(greenButton.snp.top).offset(-8)
            make.height.equalTo(12)
        }
        
        createButton.snp.makeConstraints { make in
            make.top.equalTo(greenButton.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(124)
            make.height.equalTo(32)
        }
    }
}
