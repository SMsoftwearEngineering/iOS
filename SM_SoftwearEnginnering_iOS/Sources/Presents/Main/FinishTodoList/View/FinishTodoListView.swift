//
//  FinishTodoListView.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/14.
//

import UIKit
import SnapKit

final class FinishTodoListView: BaseView {
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let folderNameButton: CustomButton = {
        let button = CustomButton(title: "작업 리스트")
        return button
    }()
    
    let filterButton: CustomButton = {
        let button = CustomButton(title: "정렬 ↓")
        return button
    }()
    
    let backButton: CustomButton = {
        let button = CustomButton(title: "뒤로가기")
        return button
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .SMPurple
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    private let itemRatio = 1.0
    private let groupRatio = 1.0
    
    override func setHierarchy() {
        self.addSubview(bgView)
        self.addSubview(folderNameButton)
        self.addSubview(filterButton)
        self.addSubview(backButton)
        self.addSubview(collectionView)
        self.addSubview(createButton)
    }
    
    override func setLayout() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        folderNameButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(48)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        
        filterButton.snp.makeConstraints { make in
            make.top.equalTo(folderNameButton.snp.bottom).offset(58)
            make.leading.equalTo(16)
            make.height.equalTo(28)
            make.width.equalTo(100)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(folderNameButton.snp.bottom).offset(58)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(28)
            make.width.equalTo(100)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(filterButton.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension FinishTodoListView {
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.cellLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
    
    private func cellLayout() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemRatio),
            heightDimension: .fractionalHeight(itemRatio)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(groupRatio),
            heightDimension: .fractionalHeight(groupRatio / 10) // Use fractionalHeight instead of fractionalWidth
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item]) // Use vertical instead of horizontal
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
