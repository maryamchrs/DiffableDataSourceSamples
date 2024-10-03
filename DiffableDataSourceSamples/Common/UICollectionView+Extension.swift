//
//  UICollectionView+Extension.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ :T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func registerNib<T: UICollectionViewCell>(_: T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func registerHeader<T: UICollectionReusableView>(_ :T.Type, kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: T.self))
    }
    
    func registerNibHeader<T: UICollectionReusableView>(_ : T.Type, kind: String, in bundle: Bundle? = nil) {
        let nib = UINib(nibName: String(describing: T.self), bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Error: could not dequeue cell with identifier: \(identifier)")
        }
        return cell
    }
    
    func dequeueSupplementaryView<T: UICollectionReusableView>(of kind: String, at indexPath: IndexPath) -> T {
        let supplementaryView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
        return supplementaryView
    }
}
