//
//  HomeViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import UIKit
import Combine

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
    
    private var deleteButtonTapSubject = PassthroughSubject<Void, Never>()
    
    var deleteButtonTap: AnyPublisher<Void, Never> {
        return deleteButtonTapSubject.eraseToAnyPublisher()
    }

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
        let input = HomeViewModel.Input(logoutButtonTap: selfView.logoutButton.tapPublisher, folderCreateButtonTap: selfView.folderCreateButton.tapPublisher, filterButtonTap: selfView.filterButton.tapPublisher, finishTaskListButtonTap: selfView.finishFilterButton.tapPublisher, deleteButtonTap: self.deleteButtonTap)
        let output = viewModel.transform(input)
    }
    
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BaseCollectionViewCell, Folder> { cell, indexPath, itemIdentifier in
            cell.titleLable.text = itemIdentifier.folderTitle
            
            cell.deleteButtonTap.sink { [weak self] in
                print("이건찍히나")
                self?.deleteButtonTapSubject.send()
            }
            .store(in: &cell.cancellableBag)

        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)

            return cell
        }
    }
    
    func snapshotAppend() {
        snapshot.appendSections([0])
        var folderArr: [Folder] = []
        

        
        for i in 1..<50 {
            folderArr.append(Folder(folderId: Int64(i), color: "1", folderTitle: "폴더제목", memberId: 3, todo: [Todo(todoId: 1, title: "", content: "", completeDate: Date(), priority: 3, wishCompleteDate: Date(), folderId: Int64(i), memberId: 3)]))
        }
        
        snapshot.appendItems(folderArr, toSection: 0)
        dataSource.apply(snapshot)
    }
}
