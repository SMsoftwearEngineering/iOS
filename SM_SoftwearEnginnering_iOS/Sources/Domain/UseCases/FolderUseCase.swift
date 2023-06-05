//
//  FolderUseCase.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

protocol FolderUseCase {
    func load(memberId: Int) -> [Folder]
    func create(with item: Folder)
    func delete(memberId: Int, folderId: ObjectId)
}

final class FolderUseCaseImpl: FolderUseCase {
    private let folderRealmRepository: FolderRealmRepository
    
    init(folderRealmRepository: FolderRealmRepository) {
        self.folderRealmRepository = folderRealmRepository
    }
    
    func load(memberId: Int) -> [Folder] {
        return folderRealmRepository.loadFolder(memberId: memberId)
    }
    
    func create(with item: Folder) {
        folderRealmRepository.createFolder(folder: item)
    }
    
    func delete(memberId: Int, folderId: ObjectId) {
        folderRealmRepository.deleteFolder(memberId: memberId, folderId: folderId)
    }
}
