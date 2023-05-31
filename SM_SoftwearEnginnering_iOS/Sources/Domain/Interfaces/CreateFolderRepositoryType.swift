//
//  FolderRepositoryType.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine

protocol CreateFolderRepository: AnyObject {
    func requestCreateFolder(query: FolderPostQuery) -> AnyPublisher<Folder, NetworkError>
}
