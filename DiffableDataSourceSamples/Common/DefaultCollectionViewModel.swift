//
//  DefaultCollectionViewModel.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chrs on 03/10/2024.
//

import Foundation

protocol DefaultCollectionViewModelProtocol {
    associatedtype Item: Hashable
    
    var model: Item { get }
    
    init(model: Item, delegate: AnyObject?)
    
    func getDataModel() -> Item
}
