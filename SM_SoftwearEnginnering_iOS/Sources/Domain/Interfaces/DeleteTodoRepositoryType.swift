//
//  DeleteTodoRepositoryType.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/24.
//

import Foundation
import Combine

protocol DeleteTodoRepository: AnyObject {
    func deleteTodo(query: DeleteTodoQuery) -> AnyPublisher<Int, NetworkError>
}
