//
//  BaseTodoCollectionViewCell.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit
import SnapKit
import Combine

class BaseTodoCollectionViewCell: UICollectionViewCell {
    
    static let baseCollectionViewIdentifier = "baseTodoCollectionViewCell"
    
    var cancellableBag = Set<AnyCancellable>()
    
    
    let checkButton: UIButton = {
        let button = UIButton()
        button.tintColor = .SMPurple
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    let containView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.SMPurple.cgColor
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "pencil.line")
        return view
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.text = "작업 폴더 제목"
        return label
    }()
    
    let cellTouchButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containView.layer.cornerRadius = 8
    }
    
    func configure() {
        self.addSubview(checkButton)
        self.addSubview(containView)
        self.addSubview(imageView)
        self.addSubview(deleteButton)
        self.addSubview(titleLable)
        self.addSubview(cellTouchButton)
    }
    
    func setConstraints() {
        checkButton.snp.makeConstraints { make in
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(4)
            make.width.equalTo(checkButton.snp.height)
            make.leading.equalTo(safeAreaLayoutGuide)
        }
        
        containView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(4)
            make.leading.equalTo(checkButton.snp.trailing).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(containView).inset(4)
            make.width.equalTo(imageView.snp.height)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.trailing.verticalEdges.equalTo(containView).inset(4)
            make.width.equalTo(deleteButton.snp.height)
        }
        
        titleLable.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(4)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-4)
            make.verticalEdges.equalTo(containView)
        }
        
        cellTouchButton.snp.makeConstraints { make in
            make.edges.equalTo(titleLable)
        }
    }
}
