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
    
    private var cellButtonTapSubject = PassthroughSubject<Void, Never>()
    
    var cellButtonTap: AnyPublisher<Void, Never> {
        return cellButtonTapSubject.eraseToAnyPublisher()
    }
    
    private var viewDidLoadSubject = PassthroughSubject<Void, Never>()
    
    var viewDidLoadEvent: AnyPublisher<Void, Never> {
        return viewDidLoadSubject.eraseToAnyPublisher()
    }

    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDidLoadSubject.send(())
        setDataSource()
        snapshotAppend()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func setAttributes() {
        selfView.backgroundColor = .clear
    }
    
    override func setBinding() {
        let input = HomeViewModel.Input(logoutButtonTap: selfView.logoutButton.tapPublisher, folderCreateButtonTap: selfView.folderCreateButton.tapPublisher, filterButtonTap: selfView.filterButton.tapPublisher, finishTaskListButtonTap: selfView.finishFilterButton.tapPublisher, deleteButtonTap: self.deleteButtonTap, cellButtonTap: self.cellButtonTap, viewDidLoad: self.viewDidLoadEvent)
        let output = viewModel.transform(input)
    }
    
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BaseCollectionViewCell, Folder> { cell, indexPath, itemIdentifier in
            cell.titleLable.text = itemIdentifier.folderTitle
            
            cell.deleteButton.tapPublisher.sink { [weak self] in
                self?.deleteButtonTapSubject.send()
            }
            .store(in: &cell.cancellableBag)
            
            cell.cellTouchButton.tapPublisher.sink { [weak self] in
                self?.cellButtonTapSubject.send()
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
            folderArr.append(Folder(folderId: Int64(i), color: "1", folderTitle: "폴더제목", memberId: 3, todo: [Todo(todoId: 1, title: "", content: "", completeDate: Date(), priority: 3, wishCompleteDate: Date(), folderId: Int64(i), memberId: 3, done: false)]))
        }
        
        snapshot.appendItems(folderArr, toSection: 0)
        dataSource.apply(snapshot)
    }
}
