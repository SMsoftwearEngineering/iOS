//
//  PostTestRepositoryType.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/01.
//

import Foundation
import Combine

protocol PostTestRepository: AnyObject {
    func postTest(query: PostTestQuery) -> AnyPublisher<PostTest, NetworkError>
}
