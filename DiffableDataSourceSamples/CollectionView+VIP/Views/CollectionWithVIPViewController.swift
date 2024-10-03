//
//  CollectionWithVIPViewController.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@MainActor protocol CollectionWithVIPDisplayLogic: AnyObject {}

@MainActor final class CollectionWithVIPViewController: UIViewController {
    // MARK: - Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("CollectionWithVIPViewController - Initialization using coder Not Allowed.")
    }
    
   @MainActor init() {
        super.init(nibName: CollectionWithVIPViewController.nibName, bundle: nil)
    }
    
    // MARK: - Deinit
    deinit {}
    
    // MARK: - Properties
    
    // MARK: Private
    
    // MARK: Public
    var interactor: CollectionWithVIPBusinessLogic?
    var router: (NSObjectProtocol & CollectionWithVIPRoutingLogic & CollectionWithVIPDataPassing)?
    
    // MARK: - Outlets
}

// MARK: - View Controller

// MARK: Life Cycle
extension CollectionWithVIPViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Methods

// MARK: Private
private extension CollectionWithVIPViewController {}

// MARK: Public
extension CollectionWithVIPViewController {}

// MARK: - Display Logic
extension CollectionWithVIPViewController: CollectionWithVIPDisplayLogic {}

// MARK: - Actions
extension CollectionWithVIPViewController {}

// MARK: - Appearance
extension CollectionWithVIPViewController {
    func setColor() {}
    
    func setFont() {}
}
