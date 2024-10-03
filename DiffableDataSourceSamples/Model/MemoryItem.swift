//
//  MemoryItem.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import Foundation

struct MemoryItem: Identifiable, Hashable {
    
    let id: UUID = UUID()
    let title: String
    let imageName: String
    let date: Date? = Date()
    var isFavorite: Bool = false
    
    static var list: [MemoryItem] = [
        .init(title: "Gheshm lake", imageName: "ImageOne"),
        .init(title: "Gheshm lake", imageName: "ImageTwo"),
        .init(title: "Gheshm rock", imageName: "ImageThree"),
        .init(title: "Gheshm rock", imageName: "ImageFour"),
        .init(title: "Gheshm", imageName: "ImageFive"),
        .init(title: "Gheshm", imageName: "ImageSix"),
        .init(title: "Marjan in Turkey", imageName: "ImageSeven"),
        .init(title: "Turkey", imageName: "ImageEight"),
        .init(title: "Turkey", imageName: "ImageNine"),
        .init(title: "Turkey", imageName: "ImageTen"),
    ]
}
