//
//  TodoPostQuery.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation

struct TodoPostQuery: Hashable {
    let title: String
    let content: String
    let priority: Int32
    let wishCompleteDate: String
    let folderId: Int64
    let memberId: Int64
}
