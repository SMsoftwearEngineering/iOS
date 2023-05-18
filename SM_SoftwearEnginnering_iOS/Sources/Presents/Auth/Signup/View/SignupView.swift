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
        label.text = "ID"
        return label
    }()
    
    let idTextField: CustomTextField = {
        let tf =  CustomTextField(placeholder: "아이디를 입력해 주세요")
        return tf
    }()
    
    let pwLabel: UILabel = {
        let label = UILabel()
        label.textColor = .SMPurple
        label.text = "ID"
        return label
    }()
    
    let pwTextField: CustomTextField = {
        let tf =  CustomTextField(placeholder: "아이디를 입력해 주세요")
        return tf
    }()
    
    let confirmLabel: UILabel = {
        let label = UILabel()
        label.textColor = .SMPurple
        label.text = "ID"
        return label
    }()
    
    let confirmTextField: CustomTextField = {
        let tf =  CustomTextField(placeholder: "아이디를 입력해 주세요")
        return tf
    }()
    
    let idImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        return view
    }()
    
    let pwImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        return view
    }()
    
    let confirmImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        return view
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
    }
    
    override func setLayout() {
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(160)
            make.leading.equalTo(safeAreaLayoutGuide).offset(80)
            make.width.equalTo(48)
            make.height.equalTo(28)
        }
    }
}
