//
//  CreateFolderRegistoryImpl.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine

final class CreateFolderRepositoryImpl: CreateFolderRepository {
    
    
    private let session: Service
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Service) {
        self.session = session
    }
    
//    func requestCreateFolder(query: FolderPostQuery) -> AnyPublisher<Folder, NetworkError> {
//        return Future<Folder, NetworkError> { promise in
//            self.session.request(target: Router.createFolder(parameters: query), type: FolderResponseDto.self).sink { completion in
//                if case .failure(let error) = completion {
//                    switch error {
//                    default:
//                        promise(.failure(error))
//                    }
//                }
//            } receiveValue: { folderResponseDTO in
//                print("repository", folderResponseDTO)
//                let folder = folderResponseDTO.toDomain
//                promise(.success(folder))
//
//            }
//            .store(in: &self.anyCancellable)
//        }.eraseToAnyPublisher()
//    }
}
