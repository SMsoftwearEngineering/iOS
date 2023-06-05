//
//  Todo.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/20.
//

import Foundation
import RealmSwift

struct Todo: Hashable {
    let todoId: ObjectId
    let title: String
    let content: String
    let completeDate: Date
    let priority: Int
    let wishCompleteDate: Date
    let folderId: ObjectId
    let memberId: Int
    var done: Bool
    let color: String
}

