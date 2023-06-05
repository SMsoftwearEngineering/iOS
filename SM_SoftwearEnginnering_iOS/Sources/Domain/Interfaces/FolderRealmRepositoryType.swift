//
//  FolderRealmRepositoryType.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

protocol FolderRealmRepository: AnyObject {
    
    func loadFolder(memberId: Int) -> [Folder]
    
    func createFolder(folder: Folder)
    
    func deleteFolder(memberId: Int, folderId: ObjectId)
}
