//
//  CollectionWithVIPDependencyContainer.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import Foundation

final class CollectionWithVIPDependencyContainer {
    
    private weak var interactor: CollectionWithVIPInteractor?
    private weak var presenter: CollectionWithVIPPresenter?
    private weak var router: CollectionWithVIPRouter?
    
}

// MARK: - Factory
extension CollectionWithVIPDependencyContainer: CollectionWithVIPFactory {
    @MainActor func makeCollectionWithVIPViewController() -> CollectionWithVIPViewController {
        let viewController = CollectionWithVIPViewController()
        let interactor = getInteractor()
        let presenter = getPresenter()
        let router = getRouter()
        let worker = CollectionWithVIPWorker()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        router.factory = self
        
        return viewController
    }
    
    func getInteractor() -> CollectionWithVIPInteractor {
        guard let interactor = self.interactor else {
            let interactor = CollectionWithVIPInteractor()
            self.interactor = interactor
            return interactor
        }
        return interactor
    }

    func getPresenter() -> CollectionWithVIPPresenter {
        guard let presenter = self.presenter else {
            let presenter = CollectionWithVIPPresenter()
            self.presenter = presenter
            return presenter
        }
        return presenter
    }
     
    func getRouter() -> CollectionWithVIPRouter {
        guard let router = self.router else {
            let router = CollectionWithVIPRouter()
            self.router = router
            return router
        }
        return router
    }
}
