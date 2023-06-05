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
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Todo>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, Todo>()
    
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
    
    var todoArr: [Todo] = []


    override func loadView() {
        view = selfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewDidLoadSubject.send(())
        setDataSource()
        snapshotAppend()
    }
    
    override func setAttributes() {
        selfView.backgroundColor = .clear
    }
    
    override func setBinding() {
        let input = TodoListViewModel.Input(todoCreateButtonTap: selfView.createButton.tapPublisher, filterButtonTap: selfView.filterButton.tapPublisher, backButtonTap: selfView.backButton.tapPublisher, deleteButtonTap: self.deleteButtonTap, cellButtonTap: self.cellButtonTap, viewDidLoad: self.viewDidLoadEvent)
        let output = viewModel.transform(input)
        
        output.folderPublish.sink { folder in
            print(folder, "폴더체크⭕️")
            let attributedTitle = NSAttributedString(string: folder.folderTitle)
            self.selfView.folderNameButton.setAttributedTitle(attributedTitle, for: .normal)
            var color: UIColor = .SMPurple
            switch folder.color {
            case "RED":
                color = .SMRed
            case "PURPLE":
                color = .SMPurple
            case "YELLOW":
                color = .SMYellow
            case "GREEN":
                color = .SMGreen
            case "ORANGE":
                color = .SMOrange
            default:
                color = .SMPink
            }
            self.selfView.folderNameButton.configuration?.baseBackgroundColor = color
            self.selfView.filterButton.configuration?.baseBackgroundColor = color
            self.selfView.backButton.configuration?.baseBackgroundColor = color
        }
    }
    
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BaseTodoCollectionViewCell, Todo> { cell, indexPath, itemIdentifier in
            cell.titleLable.text = itemIdentifier.title
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
        
        snapshot.appendItems(todoArr, toSection: 0)
        dataSource.apply(snapshot)
    }
}
