//
//  FolderListDTO.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

final class FolderRealmDTO: Object {
    @Persisted var folderId: Int64
    @Persisted var color: String
    @Persisted var folderTitle: String
    @Persisted(primaryKey: true) var memberId: Int64
    @Persisted var todo: List<TodoRealmDTO?>
    
    convenience init(folderId: Int64, color: String, folderTitle: String, memberId: Int64, todo: [TodoRealmDTO?]) {
        self.init()
        self.folderId = folderId
        self.color = color
        self.folderTitle = folderTitle
        self.memberId = memberId
        self.todo.append(objectsIn: todo.compactMap { $0 }) // todo 배열을 List로 변환하여 추가
    }
}

extension FolderRealmDTO {
    func toDomain() -> Folder {
        return .init(folderId: folderId, color: color, folderTitle: folderTitle, memberId: memberId, todo: todo.map { $0?.toDomain() })
    }
}
