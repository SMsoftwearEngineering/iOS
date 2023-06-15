//
//  HomeView.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import UIKit
import SnapKit

final class HomeView: BaseView {
    let logoutButton: CustomButton = {
        let button = CustomButton(title: "로그아웃")
        return button
    }()
    
    let folderCreateButton: CustomButton = {
        let button = CustomButton(title: "폴더 생성")
        return button
    }()
    
    let filterButton: CustomButton = {
        let button = CustomButton(title: "미완료 작업 리스트")
        return button
    }()
    
    let finishFilterButton: CustomButton = {
        let button = CustomButton(title: "완료한 작업 리스트")
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
        self.addSubview(logoutButton)
        self.addSubview(folderCreateButton)
        self.addSubview(filterButton)
        self.addSubview(finishFilterButton)
        self.addSubview(collectionView)
        self.addSubview(createButton)
    }
    
    override func setLayout() {
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(48)
            make.leading.equalTo(16)
            make.height.equalTo(28)
            make.width.equalTo(100)
        }
        
        folderCreateButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(48)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(28)
            make.width.equalTo(100)
        }
        
        filterButton.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(58)
            make.leading.equalTo(16)
            make.height.equalTo(28)
            make.width.equalTo(200)
        }
        
        finishFilterButton.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(58)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(28)
            make.leading.equalTo(filterButton.snp.trailing).offset(24)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(filterButton.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        createButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.width.equalTo(40)
        }
    }
}

extension HomeView {
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
