//
//  FolderUseCase.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation

protocol FolderUseCase {
    func load(memberId: Int64) -> [Folder]
    func create(with item: Folder)
    func delete(memberId: Int64, folderId: Int64)
}

final class FolderUseCaseImpl: FolderUseCase {
    private let folderRealmRepository: FolderRealmRepository
    
    init(folderRealmRepository: FolderRealmRepository) {
        self.folderRealmRepository = folderRealmRepository
    }
    
    func load(memberId: Int64) -> [Folder] {
        return folderRealmRepository.loadFolder(memberId: memberId)
    }
    
    func create(with item: Folder) {
        folderRealmRepository.createFolder(folder: item)
    }
    
    func delete(memberId: Int64, folderId: Int64) {
        folderRealmRepository.deleteFolder(memberId: memberId, folderId: folderId)
    }
}
