//
//  CollectionWithVIPPresenter.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import UIKit

protocol CollectionWithVIPPresentationLogic {
    func presentCollectionData(response: CollectionWithVIP.ShowCollectionData.Response) async
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
    func presentCollectionData(response: CollectionWithVIP.ShowCollectionData.Response) async {
        var cellViewModel = [CollectionWithVIP.Section : [any DefaultCollectionViewModelProtocol]]()
        cellViewModel[.favoritePlaces] = response.famousPlace.map{ LandscapeCollectionViewModel.init(model: $0)}
        let delegate: MemoryCollectionViewCellDelegate? = viewController
        cellViewModel[.memories] = response.memories.map{ MemoryCollectionViewModel.init(model: $0, delegate: delegate)}
        let viewModel = CollectionWithVIP.ShowCollectionData.ViewModel(cellViewModel: cellViewModel)
        await viewController?.displayCollectionViewData(viewModel: viewModel)
    }
}
