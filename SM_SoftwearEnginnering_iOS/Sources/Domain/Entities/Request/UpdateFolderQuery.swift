//
//  UpdateFolderQuery.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation

struct UpdateFolderQuery: Hashable {
    let folderId: Int64
    let folderTitle: String
    let color: String
}
