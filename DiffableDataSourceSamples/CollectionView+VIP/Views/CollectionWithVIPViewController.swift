//
//  CollectionWithVIPViewController.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.

import UIKit

@MainActor protocol CollectionWithVIPDisplayLogic: AnyObject, MemoryCollectionViewCellDelegate {
    func displayCollectionViewData(viewModel: CollectionWithVIP.ShowCollectionData.ViewModel)
}

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
    
    // MARK: - typealias
    typealias DataSource = UICollectionViewDiffableDataSource<CollectionWithVIP.Section, UUID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CollectionWithVIP.Section, UUID>
    
    // MARK: - Properties
    private var dataSource: DataSource!
    
    // MARK: - Properties
    
    // MARK: Private
    private(set) var cellViewModel = [CollectionWithVIP.Section: [any DefaultCollectionViewModelProtocol]]()
    
    // MARK: Public
    var interactor: CollectionWithVIPBusinessLogic?
    var router: (NSObjectProtocol & CollectionWithVIPRoutingLogic & CollectionWithVIPDataPassing)?
    
    // MARK: - Outlets
    @IBOutlet private(set) weak var collectionView: UICollectionView!
}

// MARK: - View Controller

// MARK: Life Cycle
extension CollectionWithVIPViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCollectionLayout()
        configureDataSource()
        applySnapshot()
        
        interactor?.viewDidLoad(request: CollectionWithVIP.ViewDidLoad.Request())
    }
}

// MARK: - Methods

// MARK: Private
private extension CollectionWithVIPViewController {
    func configureCollectionView() {
        collectionView.registerNib(MemoryCollectionViewCell.self)
        collectionView.registerNib(LandscapeCollectionViewCell.self)
        collectionView.delegate = self
    }
    
    func configureCollectionLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionType = CollectionWithVIP.Section(rawValue: sectionIndex) else { return nil }
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
        dataSource = UICollectionViewDiffableDataSource<CollectionWithVIP.Section, UUID>(collectionView: collectionView) { [weak self]
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: UUID) -> UICollectionViewCell? in
            
            guard let self = self, let sectionType = CollectionWithVIP.Section(rawValue: indexPath.section) else {
                return UICollectionViewCell()
            }
            
            switch sectionType {
            case .memories:
                guard let memoriesViewModel = self.cellViewModel[sectionType] as? [MemoryCollectionViewModel],
                      let memoryViewModel = memoriesViewModel.first(where: { $0.getDataModel().id == identifier })
                else {
                    return UICollectionViewCell()
                }
                let cell: MemoryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.setViewModel(memoryViewModel)
                return cell
                
            case .favoritePlaces:
                guard let placesViewModel = self.cellViewModel[sectionType] as? [LandscapeCollectionViewModel],
                      let placeViewModel = placesViewModel.first(where: { $0.getDataModel().id == identifier })
                else {
                    return UICollectionViewCell()
                }
                let cell: LandscapeCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                cell.configCell(placeViewModel)
                return cell
            }
        }
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<CollectionWithVIP.Section, UUID>()
        snapshot.appendSections([CollectionWithVIP.Section.favoritePlaces, CollectionWithVIP.Section.memories])
        
        guard let memoriesViewModel = self.cellViewModel[.memories] as? [MemoryCollectionViewModel] else { return }
        guard let placesViewModel = self.cellViewModel[.favoritePlaces] as? [LandscapeCollectionViewModel] else { return }
        
        snapshot.appendItems(placesViewModel.map({$0.getDataModel()}).map({$0.id}), toSection: .favoritePlaces)
        snapshot.appendItems(memoriesViewModel.map({$0.getDataModel()}).map({$0.id}), toSection: .memories)
        
        if #available(iOS 15, *) {
            dataSource.applySnapshotUsingReloadData(snapshot)
        } else {
            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

// MARK: Public
extension CollectionWithVIPViewController {}

// MARK: - Display Logic
extension CollectionWithVIPViewController: CollectionWithVIPDisplayLogic {
    func displayCollectionViewData(viewModel: CollectionWithVIP.ShowCollectionData.ViewModel) {
        cellViewModel = viewModel.cellViewModel
        applySnapshot()
    }
}

// MARK: - Actions
extension CollectionWithVIPViewController {}

// MARK: - Appearance
extension CollectionWithVIPViewController {
    func setColor() {}
    
    func setFont() {}
}

// MARK: - UICollectionViewDelegate
extension CollectionWithVIPViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let item = dataSource.itemIdentifier(for: indexPath) else {
//            return
//        }
    }
}

// MARK: - MemoryCollectionViewCellDelegate
extension CollectionWithVIPViewController {
    func favoriteButtonTapped(dataModel: MemoryItem) {
        print("favoriteButtonTapped")
    }
}
