//
//  Todo.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation

struct Todo: Hashable {
    let todoId: Int
    let title: String
    let content: String
    let completeDate: Date
    let priority: Int
    let wishCompleteDate: Date
    let folderId: Int
    let memberId: Int
    let done: Bool
}

