//
//  LoginView.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit
import SnapKit

final class LoginView: BaseView {
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .SMPink
        return view
    }()
    
    let titleView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "TodoTitle")
        return view
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "ID"
        return label
    }()
    
    let pwLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "P/W"
        return label
    }()
    
    let idTextField: CustomTextFieldView = {
        let tf = CustomTextFieldView(placeholder: "")
        return tf
    }()
    
    let pwTextField: CustomTextFieldView = {
        let tf = CustomTextFieldView(placeholder: "")
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOGIN", for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    override func setHierarchy() {
        self.addSubview(bgView)
        self.addSubview(titleView)
        self.addSubview(idLabel)
        self.addSubview(idTextField)
        self.addSubview(pwLabel)
        self.addSubview(pwTextField)
        self.addSubview(loginButton)
        self.addSubview(signupButton)
    }
    
    override func setLayout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(80)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(80)
            make.height.equalTo(46)
        }
        
        idLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(28)
            make.top.equalTo(titleView.snp.bottom).offset(175)
            make.height.equalTo(28)
            make.width.equalTo(46)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel)
            make.leading.equalTo(idLabel.snp.trailing).offset(8)
            make.bottom.equalTo(idLabel)
            make.width.equalTo(172)
        }
        
        pwLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(28)
            make.top.equalTo(idTextField.snp.bottom).offset(28)
            make.height.equalTo(28)
            make.width.equalTo(46)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(pwLabel)
            make.leading.equalTo(pwLabel.snp.trailing).offset(8)
            make.bottom.equalTo(pwLabel)
            make.width.equalTo(172)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.equalTo(idTextField.snp.trailing).offset(24)
            make.top.equalTo(idTextField.snp.top)
            make.bottom.equalTo(pwTextField.snp.bottom)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-24)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(58)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(134)
            make.height.equalTo(43)
        }
        
        pwTextField.tf.isSecureTextEntry = true
    }
}
