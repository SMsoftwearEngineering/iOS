//
//  Login.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/24.
//

import Foundation

struct Login: Hashable {
    let memberId: Int64
    let email: String
    let name: String?
    let token: String
}
