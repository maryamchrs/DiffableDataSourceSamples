//
//  CollectionWithVIPFactory.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import Foundation

typealias CollectionWithVIPFactory = CollectionWithVIPFactoryProtocol & CollectionWithVIPServiceFactory

protocol CollectionWithVIPFactoryProtocol {
    func makeCollectionWithVIPViewController() -> CollectionWithVIPViewController
}

protocol CollectionWithVIPServiceFactory {}
