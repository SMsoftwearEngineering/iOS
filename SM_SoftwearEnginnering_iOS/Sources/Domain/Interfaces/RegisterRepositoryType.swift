//
//  RegisterRepositoryType.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/18.
//

import Foundation
import Combine

protocol RegisterRepository: AnyObject {
    func requestRegister(register: RegisterQuery) -> AnyPublisher<Int, NetworkError>
}
