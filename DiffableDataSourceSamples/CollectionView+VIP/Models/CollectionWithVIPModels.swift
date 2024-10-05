//
//  CollectionWithVIPModels.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import UIKit

enum CollectionWithVIP {
    // MARK: Use cases
    enum Section: Int, CaseIterable {
        case favoritePlaces
        case memories
    }
    
    enum ViewDidLoad {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
            
        }
    }
    
    enum ShowCollectionData {
        struct Request {
        }
        struct Response {
            let memories: [MemoryItem]
            let famousPlace: [FamousPlace]
        }
        struct ViewModel {
            let cellViewModel: [CollectionWithVIP.Section: [any DefaultCollectionViewModelProtocol]]
        }
    }
}
