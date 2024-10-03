//
//  CollectionWithVIPPresenter.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import UIKit

protocol CollectionWithVIPPresentationLogic {
    func presentSomething(response: CollectionWithVIP.ShowCollectionData.Response) async
}

final class CollectionWithVIPPresenter {
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: CollectionWithVIPDisplayLogic?
}

// MARK: - Methods
// MARK: Public
extension CollectionWithVIPPresenter {}

// MARK: Private
private extension CollectionWithVIPPresenter {}

// MARK: - Presentation Logic
extension CollectionWithVIPPresenter: CollectionWithVIPPresentationLogic {
    func presentSomething(response: CollectionWithVIP.ShowCollectionData.Response) async {
        
    }
}
