//
//  Results + Extension.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/06/05.
//

import Foundation
import RealmSwift

extension Results {
    var toArray: [Element] {
        return compactMap { $0 }
    }
}
