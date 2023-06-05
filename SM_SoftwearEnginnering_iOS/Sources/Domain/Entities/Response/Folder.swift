//
//  Folder.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//
import Foundation
import RealmSwift

struct Folder: Hashable {
    let folderId: ObjectId
    let color: String
    let folderTitle: String
    let memberId: Int
}
