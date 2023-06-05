//
//  RealmStorage.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

final class RealmStorage {
    static let shared = RealmStorage()
    private let realm = try! Realm()
    
    func readFolderList(memberId: Int64) -> Results<FolderRealmDTO> {
        return realm.objects(FolderRealmDTO.self).where { $0.memberId == memberId}
    }
    
    func createFolder(folder: FolderRealmDTO) {
        try! realm.write {
            realm.add(folder)
        }
    }
    
    
}
