//
//  TodoListViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit
import Combine

final class TodoListViewController: BaseViewController {
    
    private let selfView = TodoListView()
    
    private let viewModel: TodoListViewModel
    
    init(viewModel: TodoListViewModel) {
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
        let input = TodoListViewModel.Input(todoCreateButtonTap: selfView.createButton.tapPublisher, filterButtonTap: selfView.filterButton.tapPublisher, backButtonTap: selfView.backButton.tapPublisher, deleteButtonTap: self.deleteButtonTap, cellButtonTap: self.cellButtonTap)
        let output = viewModel.transform(input)
    }
    
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BaseTodoCollectionViewCell, Folder> { cell, indexPath, itemIdentifier in
            cell.titleLable.text = itemIdentifier.folderTitle
            cell.imageView.image = UIImage(systemName: "pencil.line")
            cell.deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
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
            folderArr.append(Folder(folderId: Int64(i), color: "1", folderTitle: "폴더제목", memberId: 3, todo: [Todo(todoId: 1, title: "", content: "", completeDate: Date(), priority: 3, wishCompleteDate: Date(), folderId: Int64(i), memberId: 3)]))
        }
        
        snapshot.appendItems(folderArr, toSection: 0)
        dataSource.apply(snapshot)
    }
}
