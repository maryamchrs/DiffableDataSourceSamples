//
//  CollectionViewWithMoreSectionsViewController.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import UIKit

class CollectionViewWithMoreSectionsViewController: UIViewController {

    // MARK: - Initializer
    init() {
        super.init(nibName: CollectionViewWithMoreSectionsViewController.nibName, bundle: CollectionViewWithMoreSectionsViewController.bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CollectionView section type
    enum Section: Int {
        case favoritePlaces
        case memories
    }
    
    enum Item {
        case memory(MemoryItem)
        case favoritePlaces(FamousPlace)
    }
    
    // MARK: - typealias
    typealias DataSource = UICollectionViewDiffableDataSource<Section, UUID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, UUID>
    
    // MARK: - Properties
    private var dataSource: DataSource!
    var model: (famousPlace: [FamousPlace], memories: [MemoryItem]) = (FamousPlace.list, MemoryItem.list)
    
    // MARK: - Outlets
    @IBOutlet weak private(set) var collectionView: UICollectionView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCollectionLayout()
        configureDataSource()
        applySnapshot()
    }

}
// MARK: - Methods
// MARK: Public

// MARK: Private
extension CollectionViewWithMoreSectionsViewController {
    func configureCollectionView() {
        collectionView.registerNib(MemoryCollectionViewCell.self)
        collectionView.registerNib(DefaultCollectionViewCell.self)
        collectionView.delegate = self
    }
    
    func configureCollectionLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            switch sectionType {
            case .favoritePlaces:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalHeight(1/3))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
                
            case .memories:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(261.0))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
            }
        }
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { [weak self]
            collectionView, indexPath, identifier -> UICollectionViewCell in
            guard let self, let sectionType = Section(rawValue: indexPath.section) else { return UICollectionViewCell() }
            switch sectionType {
            case .memories:
                let memory = self.model.memories.first(where: { $0.id == identifier })!
                let cell: MemoryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setViewModel(MemoryCollectionViewModel(dataModel: memory))
                return cell
            case .favoritePlaces:
                let place = self.model.famousPlace.first(where: { $0.id == identifier })!
                let cell: DefaultCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setViewModel(DefaultCollectionViewModel(dataModel: place))
                return cell
            }
        }
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([Section.favoritePlaces, Section.memories])
        snapshot.appendItems(model.famousPlace.map({$0.id}), toSection: .favoritePlaces)
        snapshot.appendItems(model.memories.map({$0.id}), toSection: .memories)
        if #available(iOS 15, *) {
            dataSource.applySnapshotUsingReloadData(snapshot)
        } else {
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension CollectionViewWithMoreSectionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
    }
}
