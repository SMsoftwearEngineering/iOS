//
//  CreateFolderView.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit
import SnapKit

final class CreateFolderView: BaseView {
    let folderNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()
    
    let folderNameTextField: CustomTextFieldView = {
        let tf = CustomTextFieldView(placeholder: "폴더 이름")
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
        self.addSubview(folderNameLabel)
        self.addSubview(folderNameTextField)
        self.addSubview(greenButton)
        self.addSubview(redButton)
        self.addSubview(yellowButton)
        self.addSubview(purpleButton)
        self.addSubview(orangeButton)
        self.addSubview(colorLabel)
        self.addSubview(createButton)

    }
    
    override func setLayout() {
        folderNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(168)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(68)
            make.height.equalTo(12)
        }
        
        folderNameTextField.snp.makeConstraints { make in
            make.top.equalTo(folderNameLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(64)
            make.height.equalTo(32)
        }
        
        greenButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
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
            make.bottom.equalTo(redButton.snp.top).offset(-8)
            make.height.equalTo(12)
        }
        
        createButton.snp.makeConstraints { make in
            make.top.equalTo(greenButton.snp.bottom).offset(168)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(124)
            make.height.equalTo(32)
        }
    }
}
