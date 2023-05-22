//
//  CustomTextLabel.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit
import SnapKit

class CustomTextLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init() {
        self.init()
        self.layer.cornerRadius = 8
        self.backgroundColor = .white
        self.textColor = .black
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CustomTextLabelView: UIView {
    var tf = CustomTextLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLayout()
    }
    
    convenience init() {
        self.init()
        self.layer.borderColor = UIColor.SMRed.cgColor
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
