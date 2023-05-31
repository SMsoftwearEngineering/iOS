//
//  GetFolderListQuery.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/26.
//

import Foundation

struct GetFolderListQuery: Hashable {
    let userId: Int64
    let pageNo: Int32
    let pageSize: Int32
    let sortBy: String
}
