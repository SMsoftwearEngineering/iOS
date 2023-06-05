//
//  FolderRealmRepositoryImpl.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

final class FolderRealmRepositoryImpl: FolderRealmRepository {
    
    let storage = try! Realm()
    
    func loadFolder(memberId: Int) -> [Folder] {
        return storage.objects(FolderRealmDTO.self).where{ $0.memberId == memberId }.toArray.map { $0.toDomain }
    }
    
    func createFolder(folder: Folder) {
        do {
            try storage.write {
                storage.add(folder.toRealm)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteFolder(memberId: Int, folderId: Int) {
        if let folder = storage.objects(FolderRealmDTO.self).first(where: {
            $0.memberId == memberId && $0.folderId == folderId
        }) {
            do {
                try storage.write {
                    storage.delete(folder)
                }
            } catch let error {
                print(error)
            }
        }
    }
}
