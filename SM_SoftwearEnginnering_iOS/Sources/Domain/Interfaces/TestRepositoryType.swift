//
//  TestRepositoryType.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/31.
//

import Foundation
import Combine

protocol TestRepository: AnyObject {
    func getTest(query: TestQuery) -> AnyPublisher<Test, NetworkError>
}
