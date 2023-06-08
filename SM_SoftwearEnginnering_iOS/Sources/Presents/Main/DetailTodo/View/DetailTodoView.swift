//
//  DetailTodoView.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit
import SnapKit

class DetailTodoView: BaseView {
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.029, green: 0.028, blue: 0.028, alpha: 0.5)
        return view
    }()
    
    let todoContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .SMRed
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    let ddayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.text = "D - 1"
        return label
    }()
    
    let createDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2020-09-11"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    let finishDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2020-09-11"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    let containTitleView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.SMRed.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 8
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let containContentView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.SMRed.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 8
        return view
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    override func setHierarchy() {
        self.addSubview(bgView)
        self.addSubview(todoContainView)
        self.addSubview(cancelButton)
        self.addSubview(ddayLabel)
        self.addSubview(createDateLabel)
        self.addSubview(finishDateLabel)
        self.addSubview(containTitleView)
        self.addSubview(containContentView)
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
    }
    
    override func setLayout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        todoContainView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(48)
            make.height.equalTo(380)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.trailing.equalTo(todoContainView).inset(8)
        }
        
        ddayLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(todoContainView).inset(16)
            make.height.equalTo(48)
            make.width.equalTo(80)
        }
        
        createDateLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(todoContainView).inset(8)
            make.leading.equalTo(ddayLabel.snp.trailing)
            make.height.equalTo(24)
        }
        
        finishDateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(todoContainView).inset(8)
            make.leading.equalTo(ddayLabel.snp.trailing)
            make.top.equalTo(createDateLabel.snp.bottom).offset(8)
            make.height.equalTo(24)
        }
        
        containTitleView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(todoContainView).inset(16)
            make.top.equalTo(finishDateLabel.snp.bottom).offset(8)
            make.height.equalTo(28)
        }
        
        containContentView.snp.makeConstraints { make in
            make.top.equalTo(containTitleView.snp.bottom).offset(8)
            make.bottom.equalTo(todoContainView.snp.bottom).offset(-16)
            make.horizontalEdges.equalTo(todoContainView).inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(containTitleView.snp.edges).inset(4)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.edges.equalTo(containContentView.snp.edges).inset(8)
        }
    }
}
