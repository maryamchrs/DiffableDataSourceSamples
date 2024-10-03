//
//  FamousPlace.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import Foundation

struct FamousPlace: Identifiable, Hashable {
    
    var id: UUID = UUID()
    var title: String
    var imageName: String
    
    static var list: [FamousPlace] = [
        .init(title: "Berlin", imageName: "Berlin"),
        .init(title: "Chile", imageName: "Chile"),
        .init(title: "China", imageName: "China"),
        .init(title: "France", imageName: "France"),
        .init(title: "Greece", imageName: "Greece"),
        .init(title: "India", imageName: "India"),
        .init(title: "Paris", imageName: "Paris"),
        .init(title: "SanFrancisco", imageName: "SanFrancisco"),
        .init(title: "SeimReap", imageName: "SeimReap"),
        .init(title: "SouthDakota", imageName: "SouthDakota"),
        .init(title: "Sydney", imageName: "Sydney")
    ]
}
