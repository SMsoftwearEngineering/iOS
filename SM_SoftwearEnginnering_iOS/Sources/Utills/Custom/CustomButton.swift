//
//  CustomButton.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(title: String) {
        self.init()
        var configuration = UIButton.Configuration.gray()
        var titleAttr = AttributedString.init(title)
        titleAttr.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        configuration.attributedTitle = titleAttr
        configuration.cornerStyle = .fixed
        configuration.baseBackgroundColor = .SMPurple
        configuration.baseForegroundColor = .white
        self.configuration = configuration
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
