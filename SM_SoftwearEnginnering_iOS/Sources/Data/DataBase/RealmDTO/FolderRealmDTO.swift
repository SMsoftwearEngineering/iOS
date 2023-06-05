//
//  FolderListDTO.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

final class FolderRealmDTO: Object {
    @Persisted var folderId: Int
    @Persisted var color: String
    @Persisted var folderTitle: String
    @Persisted var memberId: Int
    
    @Persisted(primaryKey: true) var objectId: ObjectId

    convenience init(folderId: Int, color: String, folderTitle: String, memberId: Int) {
        self.init()
        self.folderId = folderId
        self.color = color
        self.folderTitle = folderTitle
        self.memberId = memberId
    }
}

extension FolderRealmDTO {
    var toDomain: Folder {
        return Folder(folderId: folderId, color: color, folderTitle: folderTitle, memberId: memberId)
    }
}

extension Folder {
    var toRealm: FolderRealmDTO {
        return FolderRealmDTO(folderId: folderId, color: color, folderTitle: folderTitle, memberId: memberId)
    }
}
