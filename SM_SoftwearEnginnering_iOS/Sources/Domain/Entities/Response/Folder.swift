//
//  Folder.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//
import Foundation

struct Folder: Hashable {
    let folderId: Int64
    let color: String
    let folderTitle: String
    let memberId: Int64
    let todo: [Todo?]
}
