//
//  MemoryCollectionViewModel.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import Foundation

final class MemoryCollectionViewModel {
    
    var dataModel: MemoryItem!
    weak var delegate: MemoryCollectionViewCellDelegate?
    
    init(dataModel: MemoryItem, delegate: MemoryCollectionViewCellDelegate? = nil) {
        self.dataModel = dataModel
        self.delegate = delegate
    }
}
