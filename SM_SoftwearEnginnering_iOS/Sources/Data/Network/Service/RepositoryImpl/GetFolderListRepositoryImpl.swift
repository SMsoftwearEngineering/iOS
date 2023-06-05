//
//  GetFolderListRepositoryImpl.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/26.
//

import Foundation
import Combine

final class GetFolderListRepositroyImpl: GetFolderListRepository {
    private let session: Service
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Service) {
        self.session = session
    }
    
//    func getFolderList() -> AnyPublisher<[Folder], NetworkError> {
//        return Future<[Folder], NetworkError> { promise in
//            self.session.request(target: Router.getFolderList, type: [FolderResponseDto].self).sink { completion in
//                if case .failure(let error) = completion {
//                    switch error {
//                    default:
//                        promise(.failure(error))
//                    }
//                }
//            } receiveValue: { folderResponseDTO in
//                let folder = folderResponseDTO.map { $0.toDomain }
//                promise(.success(folder))
//            }
//            .store(in: &self.anyCancellable)
//        }.eraseToAnyPublisher()
//    }
}
