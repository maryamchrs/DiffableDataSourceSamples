//
//  MemoryCollectionViewModel.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import Foundation

final class MemoryCollectionViewModel: DefaultCollectionViewModelProtocol {
    var model: MemoryItem
    weak var delegate: MemoryCollectionViewCellDelegate?
    
    init(model: MemoryItem, delegate: AnyObject? = nil) {
        self.model = model
        self.delegate = delegate as? MemoryCollectionViewCellDelegate
    }
    
    func getDataModel() -> MemoryItem {
        model
    }
}
