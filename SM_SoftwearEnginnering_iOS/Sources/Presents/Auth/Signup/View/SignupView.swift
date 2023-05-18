//
//  SignupView.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit
import SnapKit

final class SignupView: BaseView {
    let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .SMPurple
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "ID"
        return label
    }()
    
    let idTextField: CustomTextFieldView = {
        let tf =  CustomTextFieldView(placeholder: "아이디를 입력해 주세요")
        return tf
    }()
    
    let pwLabel: UILabel = {
        let label = UILabel()
        label.textColor = .SMPurple
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "P/W"
        return label
    }()
    
    let pwTextField: CustomTextFieldView = {
        let tf =  CustomTextFieldView(placeholder: "비밀번호를 입력해 주세요")
        return tf
    }()
    
    let confirmLabel: UILabel = {
        let label = UILabel()
        label.textColor = .SMPurple
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Confirm P/W"
        return label
    }()
    
    let confirmTextField: CustomTextFieldView = {
        let tf =  CustomTextFieldView(placeholder: "비밀번호를 입력해 주세요")
        return tf
    }()
    
    let idImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        view.tintColor = .SMPurple
        return view
    }()
    
    let pwImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "lock.fill")
        view.tintColor = .SMPurple
        return view
    }()
    
    let confirmImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "checkmark.circle")
        view.tintColor = .SMPurple
        return view
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .SMPurple
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func setHierarchy() {
        self.addSubview(idLabel)
        self.addSubview(idTextField)
        self.addSubview(idImgView)
        self.addSubview(pwLabel)
        self.addSubview(pwTextField)
        self.addSubview(pwImgView)
        self.addSubview(confirmLabel)
        self.addSubview(confirmTextField)
        self.addSubview(confirmImgView)
        self.addSubview(signupButton)
    }
    
    override func setLayout() {
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(160)
            make.leading.equalTo(safeAreaLayoutGuide).offset(60)
            make.width.equalTo(48)
            make.height.equalTo(28)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel)
            make.leading.equalTo(idLabel.snp.trailing).offset(8)
            make.bottom.equalTo(idLabel)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-60)
        }
        
        idImgView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(idTextField.snp.verticalEdges).inset(4)
            make.trailing.equalTo(idTextField.snp.trailing).offset(-4)
            make.width.equalTo(idImgView.snp.height)
        }
        
        pwLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(72)
            make.leading.equalTo(safeAreaLayoutGuide).offset(60)
            make.width.equalTo(48)
            make.height.equalTo(28)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(pwLabel)
            make.leading.equalTo(pwLabel.snp.trailing).offset(8)
            make.bottom.equalTo(pwLabel)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-60)
        }
        
        pwImgView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(pwTextField.snp.verticalEdges).inset(4)
            make.trailing.equalTo(pwTextField.snp.trailing).offset(-4)
            make.width.equalTo(pwImgView.snp.height)
        }
        
        confirmLabel.snp.makeConstraints { make in
            make.top.equalTo(pwLabel.snp.bottom).offset(62)
            make.leading.equalTo(safeAreaLayoutGuide).offset(60)
            make.width.equalTo(48)
            make.height.equalTo(48)
        }
        
        confirmTextField.snp.makeConstraints { make in
            make.verticalEdges.equalTo(confirmLabel.snp.verticalEdges).inset(10)
            make.leading.equalTo(confirmLabel.snp.trailing).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-60)
        }
        
        confirmImgView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(confirmTextField.snp.verticalEdges).inset(4)
            make.trailing.equalTo(confirmTextField.snp.trailing).offset(-4)
            make.width.equalTo(confirmImgView.snp.height)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(confirmTextField.snp.bottom).offset(62)
            make.leading.equalTo(confirmLabel.snp.leading)
            make.trailing.equalTo(confirmTextField.snp.trailing)
            make.height.equalTo(40)
        }
    }
}
