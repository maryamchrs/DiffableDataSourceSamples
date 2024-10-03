//
//  CollectionWithVIPInteractor.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import UIKit

protocol CollectionWithVIPBusinessLogic {
    func viewDidLoad(request: CollectionWithVIP.ViewDidLoad.Request)
}

protocol CollectionWithVIPDataStore {}

final class CollectionWithVIPInteractor: CollectionWithVIPDataStore {
    
    // MARK: - Properties
    
    // MARK: Public
    var presenter: CollectionWithVIPPresentationLogic?
    var worker: CollectionWithVIPWorkerLogic?
}

// MARK: - Methods
// MARK: Public
extension CollectionWithVIPInteractor {}

// MARK: Private
private extension CollectionWithVIPInteractor {}

// MARK: - Business Logics
extension CollectionWithVIPInteractor: CollectionWithVIPBusinessLogic {
    func viewDidLoad(
        request: CollectionWithVIP.ViewDidLoad.Request
    ) {
        Task {
            await presenter?.presentCollectionData(
                response: CollectionWithVIP.ShowCollectionData.Response(
                    memories: MemoryItem.list,
                    famousPlace: FamousPlace.list
                )
            )
        }
    }
}
