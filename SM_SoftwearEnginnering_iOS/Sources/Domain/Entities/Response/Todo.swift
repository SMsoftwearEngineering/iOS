//
//  Todo.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation

struct Todo: Hashable {
    let todoId: Int64
    let title: String
    let content: String
    let completeDate: Date
    let priority: Int32
    let wishCompleteDate: Date
    let folderId: Int64
    let memberId: Int64
}

