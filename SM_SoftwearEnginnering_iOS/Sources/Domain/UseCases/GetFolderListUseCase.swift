//
//  GetFolderListUseCase.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/26.
//

import Foundation
import Combine

//protocol GetFolderListUseCase {
//    func excute() -> AnyPublisher<[Folder], NetworkError>
//}
//
//final class GetFolderListUseCaseImpl: GetFolderListUseCase {
//    let getFolderListRepository: GetFolderListRepository
//    private var anyCancellable = Set<AnyCancellable>()
//
//    init(getFolderListRepository: GetFolderListRepository) {
//        self.getFolderListRepository = getFolderListRepository
//    }
//
//    func excute() -> AnyPublisher<[Folder], NetworkError> {
////        let getFolderListQuery = GetFolderListQuery(userId: userId, pageNo: pageNo, pageSize: pageSize, sortBy: sortBy)
//        return Future<[Folder], NetworkError> { [weak self] promise in
//            guard let self else { return }
//            print("getFolderListQuery")
//            self.getFolderListRepository.getFolderList().sink { completion in
//                if case .failure(let error) = completion {
//                    switch error {
//                    default:
//                        promise(.failure(error))
//                    }
//                }
//            } receiveValue: { folder in
//                promise(.success(folder))
//            }
//            .store(in: &self.anyCancellable)
//        }
//        .eraseToAnyPublisher()
//    }
//}
