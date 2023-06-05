//
//  CreateFolderUseCase.swift
//  SM_SoftwearEnginnering_iOS
//
//  Created by 이병현 on 2023/05/22.
//

import Foundation
import Combine

protocol CreateFolderUseCase {
    func excute(folderTitle: String, memberId: Int64, color: String) -> AnyPublisher<Folder, NetworkError>
}

final class CreateFolderUseCaseImpl: CreateFolderUseCase {
    let createFolderRepository: CreateFolderRepository
    private var anyCancellable = Set<AnyCancellable>()
    
    init(createFolderRepository: CreateFolderRepository) {
        self.createFolderRepository = createFolderRepository
    }
    
    func excute(folderTitle: String, memberId: Int64, color: String) -> AnyPublisher<Folder, NetworkError> {
        let createFolderQuery = FolderPostQuery(folderTitle: folderTitle, memberId: memberId, color: color)
        return Future<Folder, NetworkError> { [weak self] promise in
            guard let self else { return }
            print("서버에게 보내는 Query", createFolderQuery)
            self.createFolderRepository.requestCreateFolder(query: createFolderQuery)
                .sink { completion in
                    if case .failure(let error) = completion {
                        switch error {
                        default:
                            promise(.failure(error))
                        }
                    }
                } receiveValue: { folder in
                    promise(.success(folder))
                }
                .store(in: &self.anyCancellable)
        }.eraseToAnyPublisher()
    }
}
