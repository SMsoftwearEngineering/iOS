//
//  HomeViewController.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import UIKit
import Combine
import RealmSwift

final class HomeViewController: BaseViewController {
    
    private let selfView = HomeView()
    
    private let viewModel: HomeViewModel
    
    private var anyCancellable = Set<AnyCancellable>()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Folder>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, Folder>()
    
    private var deleteButtonTapSubject = PassthroughSubject<Folder, Never>()
    
    var deleteButtonTap: AnyPublisher<Folder, Never> {
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
    
    private var selectedFolder = PassthroughSubject<Folder, Never>()
    
    var folder: AnyPublisher<Folder, Never> {
        return selectedFolder.eraseToAnyPublisher()
    }
    var folderArr: [Folder] = []
    
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
        let input = HomeViewModel.Input(logoutButtonTap: selfView.logoutButton.tapPublisher, folderCreateButtonTap: selfView.folderCreateButton.tapPublisher, filterButtonTap: selfView.filterButton.tapPublisher, finishTaskListButtonTap: selfView.finishFilterButton.tapPublisher, deleteButtonTap: self.deleteButtonTap, cellButtonTap: self.cellButtonTap, viewDidLoad: self.viewDidLoadEvent, folder: self.folder)
        let output = viewModel.transform(input)
        
        output.folderListPublish
            .receive(on: DispatchQueue.main)
            .sink { [weak self] folder in
                guard let self = self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Int, Folder>()
                snapshot.appendSections([0])
                snapshot.appendItems(folder)
                self.dataSource.apply(snapshot)
            }
            .store(in: &anyCancellable)
    }
    
    func setDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BaseCollectionViewCell, Folder> { cell, indexPath, itemIdentifier in
            cell.titleLable.text = itemIdentifier.folderTitle
            
            cell.deleteButton.tapPublisher.sink { [weak self] in
                self?.deleteButtonTapSubject.send(itemIdentifier)
            }
            .store(in: &cell.cancellableBag)
            
            cell.cellTouchButton.tapPublisher.sink { [weak self] in
                self?.cellButtonTapSubject.send()
                self?.selectedFolder.send(itemIdentifier)
            }
            .store(in: &cell.cancellableBag)
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
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: selfView.collectionView) { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        }
    }
    
    func snapshotAppend() {
        snapshot.appendSections([0])
        print(folderArr, "folderId")
        snapshot.appendItems(folderArr, toSection: 0)
        dataSource.apply(snapshot)
    }
}
