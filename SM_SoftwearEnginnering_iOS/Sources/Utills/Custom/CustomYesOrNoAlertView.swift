//
//  CustomOkNoAlertView.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit
import SnapKit

class CustomYesOrNoAlertView: BaseView {
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.029, green: 0.028, blue: 0.028, alpha: 0.5)
        return view
    }()
    
    let alertContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "exclamationmark.circle")
        view.tintColor = .SMRed
        return view
    }()
    
    let alertLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .SMRed
        button.setTitle("확인", for: .normal)
        button.layer.cornerRadius = 4
        return button
    }()
    
    let noButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .SMRed
        button.setTitle("아니요", for: .normal)
        button.layer.cornerRadius = 4
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text: String) {
        self.init()
        self.alertLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHierarchy() {
        self.addSubview(bgView)
        self.addSubview(alertContainView)
        self.addSubview(imageView)
        self.addSubview(okButton)
        self.addSubview(noButton)
        self.addSubview(alertLabel)

    }
    
    override func setLayout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alertContainView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(48)
            make.height.equalTo(148)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.leading.equalTo(alertContainView).inset(16)
            make.height.width.equalTo(48)
        }
        
        okButton.snp.makeConstraints { make in
            make.bottom.equalTo(alertContainView.snp.bottom).offset(-20)
            make.leading.equalTo(alertContainView.snp.leading).offset(20)
            make.height.equalTo(24)
            make.width.equalTo(100)
        }
        
        noButton.snp.makeConstraints { make in
            make.bottom.equalTo(alertContainView.snp.bottom).offset(-20)
            make.trailing.equalTo(alertContainView.snp.trailing).offset(-20)
            make.height.equalTo(24)
            make.width.equalTo(100)
        }
        
        alertLabel.snp.makeConstraints { make in
            make.centerX.equalTo(alertContainView)
            make.width.equalTo(160)
            make.top.equalTo(imageView.snp.top)
            make.bottom.equalTo(okButton.snp.top).offset(-20)
        }
    }
}
