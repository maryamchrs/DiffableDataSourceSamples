//
//  CollectionWithOneSectionViewController.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import UIKit

final class CollectionWithOneSectionViewController: UIViewController {
    
    // MARK: - Initializer
    init() {
        super.init(nibName: CollectionWithOneSectionViewController.nibName, bundle: CollectionWithOneSectionViewController.bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CollectionView section type
    enum Section: Int {
        case main
    }
    
    // MARK: - typealias
    typealias DataSource = UICollectionViewDiffableDataSource<Section, MemoryItem.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MemoryItem.ID>
    
    // MARK: - typealias
    private var dataSource: DataSource!
    private var memories: [MemoryItem] = MemoryItem.list
    
    // MARK: - Outlets
    @IBOutlet private(set) weak var collectionView: UICollectionView!
   
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
extension CollectionWithOneSectionViewController {
    
    func configureCollectionView() {
        collectionView.registerNib(MemoryCollectionViewCell.self)
    }
    
    func configureCollectionLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            let edgeSpacing = NSCollectionLayoutEdgeSpacing(
                leading: .fixed(8),
                top: .fixed(0),
                trailing: .fixed(8),
                bottom: .fixed(0)
            )
            switch sectionType {
            case .main:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .estimated(261.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                item.edgeSpacing = edgeSpacing
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(1.0))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                return section
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { [weak self]
            collectionView, indexPath, identifier -> UICollectionViewCell in
            guard let self else { return UICollectionViewCell() }
            let memory = self.memories.first(where: { $0.id == identifier })!
            let cell: MemoryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            let delegate: MemoryCollectionViewCellDelegate? = self
            cell.setViewModel(MemoryCollectionViewModel.init(model: memory, delegate: delegate))
            return cell
        }
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        let memoryIds = memories.map { $0.id }
        snapshot.appendSections([.main])
        snapshot.appendItems(memoryIds, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)//applySnapshotUsingReloadData(snapshot)
    }
}

// MARK: - UICollectionViewDelegate
extension CollectionWithOneSectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
    }
}

extension CollectionWithOneSectionViewController: MemoryCollectionViewCellDelegate {
    func favoriteButtonTapped(dataModel: MemoryItem) {
        print("favoriteButtonTapped")
    }
}
