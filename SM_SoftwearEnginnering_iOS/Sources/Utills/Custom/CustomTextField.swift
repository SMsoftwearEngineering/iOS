//
//  CustomTextField.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import UIKit
import SnapKit

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(placeholder: String?) {
        self.init()
        self.layer.cornerRadius = 8
        self.backgroundColor = .white
        self.placeholder = placeholder
        self.textColor = .black
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CustomTextFieldView: UIView {
    var tf = CustomTextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLayout()
    }
    
    convenience init(placeholder: String?) {
        self.init()
        tf.placeholder = placeholder
        self.layer.borderColor = UIColor.SMPurple.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 8
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        let edges: CGFloat = 16
        
        self.addSubview(tf)
        tf.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(edges)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
}
