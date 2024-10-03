//
//  CollectionWithVIPModels.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import UIKit

enum CollectionWithVIP {
    // MARK: Use cases
    enum Section {
        case favoritePlaces([any DefaultCollectionViewModelProtocol])
        case memories([any DefaultCollectionViewModelProtocol])
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
        }
        struct ViewModel {
        }
    }
}
