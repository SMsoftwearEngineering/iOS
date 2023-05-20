//
//  HomeViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    private let selfView = HomeView()
    
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Folder>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, Folder>()
    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataSource()
        snapshotAppend()
    }
    
    override func setAttributes() {
        selfView.backgroundColor = .clear
    }
    
    override func setBinding() {
        let input = HomeViewModel.Input(loginButtonTap: selfView.logoutButton.tapPublisher)
        let output = viewModel.transform(input)
    }
    
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BaseCollectionViewCell, Folder> { cell, indexPath, itemIdentifier in
            cell.titleLable.text = itemIdentifier.folderTitle
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
    
    func snapshotAppend() {
        snapshot.appendSections([0])
        var folderArr: [Folder] = []
        
        folderArr.append(Folder(folderId: 12, color: "1", folderTitle: "폴더제목", memberId: 3, todo: [Todo(todoId: 1, title: "", content: "", completeDate: Date(), priority: 3, wishCompleteDate: Date(), folderId: 4, memberId: 3)]))
        
        snapshot.appendItems(folderArr, toSection: 0)
        dataSource.apply(snapshot)
    }
}
