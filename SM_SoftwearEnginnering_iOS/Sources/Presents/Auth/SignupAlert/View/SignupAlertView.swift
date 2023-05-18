//
//  SignupAlertView.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit
import SnapKit

final class SignupAlertView: BaseView {
    let alertView: CustomAlertView = {
       let view = CustomAlertView(text: "이미 가입된 회원입니다.")
        return view
    }()
    
    override func setHierarchy() {
        self.backgroundColor = .clear
        self.addSubview(alertView)
    }
    
    override func setLayout() {
        alertView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
