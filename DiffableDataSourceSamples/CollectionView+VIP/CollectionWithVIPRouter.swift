//
//  CollectionWithVIPRouter.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import UIKit

protocol CollectionWithVIPRoutingLogic {
    //    func navigateToSomewhere()
}

protocol CollectionWithVIPDataPassing {
    var dataStore: CollectionWithVIPDataStore? { get }
}

final class CollectionWithVIPRouter: NSObject, CollectionWithVIPDataPassing {
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: CollectionWithVIPViewController?
    var dataStore: CollectionWithVIPDataStore?
    var factory: CollectionWithVIPFactoryProtocol?
}

// MARK: - Methods
// MARK: Public
extension CollectionWithVIPRouter {}

// MARK: Private
private extension CollectionWithVIPRouter {}

// MARK: - Routing Logic
extension CollectionWithVIPRouter: CollectionWithVIPRoutingLogic {

}
