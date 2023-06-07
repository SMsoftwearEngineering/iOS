//
//  TodoListViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import UIKit
import Combine
import RealmSwift

final class TodoListViewController: BaseViewController {
    
    private let selfView = TodoListView()
    
    private let viewModel: TodoListViewModel
    
    private var anyCancellable = Set<AnyCancellable>()

    
    init(viewModel: TodoListViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Todo>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, Todo>()
    
    private var deleteButtonTapSubject = PassthroughSubject<Todo, Never>()
    
    
    var deleteButtonTap: AnyPublisher<Todo, Never> {
        return deleteButtonTapSubject.eraseToAnyPublisher()
    }
    
    private var cellButtonTapSubject = PassthroughSubject<Todo, Never>()
    
    var cellButtonTap: AnyPublisher<Todo, Never> {
        return cellButtonTapSubject.eraseToAnyPublisher()
    }
    
    private var checkButtonTapSubject = PassthroughSubject<Todo, Never>()
    
    var checkButtonTap: AnyPublisher<Todo, Never> {
        return checkButtonTapSubject.eraseToAnyPublisher()
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
        let input = TodoListViewModel.Input(todoCreateButtonTap: selfView.createButton.tapPublisher, filterButtonTap: selfView.filterButton.tapPublisher, backButtonTap: selfView.backButton.tapPublisher, deleteButtonTap: self.deleteButtonTap, cellButtonTap: self.cellButtonTap, viewDidLoad: self.viewDidLoadEvent, checkButtonTap: self.checkButtonTap)
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
        .store(in: &anyCancellable)
        
        output.todoPublish.sink { todo in
            guard let todo else { return }
            for i in todo {
                self.todoArr.append(i ?? Todo(todoId: ObjectId(), title: "", content: "", completeDate: Date(), priority: 0, wishCompleteDate: Date(), folderId: ObjectId(), memberId: 0, done: false, color: "PURPLE"))
            }
        }
        .store(in: &anyCancellable)
    }
    
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BaseTodoCollectionViewCell, Todo> { cell, indexPath, itemIdentifier in
            cell.titleLable.text = itemIdentifier.title
            cell.imageView.image = UIImage(systemName: "pencil.line")
            cell.deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
            cell.deleteButton.tapPublisher.sink { [weak self] in
                self?.deleteButtonTapSubject.send(itemIdentifier)
            }
            .store(in: &cell.cancellableBag)
            
            cell.cellTouchButton.tapPublisher.sink { [weak self] in
                self?.cellButtonTapSubject.send(itemIdentifier)
            }
            .store(in: &cell.cancellableBag)
            
            cell.checkButton.tapPublisher.sink { [weak self] in
                self?.checkButtonTapSubject.send(itemIdentifier)
            }
            .store(in: &cell.cancellableBag)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            var color: UIColor = .SMPurple
            switch itemIdentifier.color {
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
            cell.deleteButton.tintColor = color
            cell.checkButton.tintColor = color
            cell.containView.layer.borderColor = color.cgColor
            cell.imageView.tintColor = color
            
            itemIdentifier.done ? cell.checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal) : cell.checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            return cell
        }
    }
    
    func snapshotAppend() {
        snapshot.appendSections([0])
        
        snapshot.appendItems(todoArr, toSection: 0)
        dataSource.apply(snapshot)
    }
}
