//
//  DefaultCollectionViewCell.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import UIKit

protocol DefaultCollectionCellDelegate: AnyObject {}

protocol DefaultCollectionModelProtocol {
    var id: UUID { get set }
    var title: String { get set }
    var imageName: String { get set}
}

final class DefaultCollectionViewModel {
    
    var dataModel: DefaultCollectionModelProtocol!
    weak var delegate: DefaultCollectionCellDelegate?
    
    init(dataModel: DefaultCollectionModelProtocol, delegate: DefaultCollectionCellDelegate? = nil) {
        self.dataModel = dataModel
        self.delegate = delegate
    }
}

final class DefaultCollectionViewCell: UICollectionViewCell {
    //MARK: - Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    //MARK: - Properties
    var viewModel: DefaultCollectionViewModel?

    //MARK: - Outlets
    @IBOutlet weak private(set) var image: UIImageView!
    @IBOutlet weak private(set) var titleLabel: UILabel!
}

//MARK: - Methods
//MARK: Public
extension DefaultCollectionViewCell {
    func setViewModel(_ viewModel: DefaultCollectionViewModel) {
        self.viewModel = viewModel
        updateUIBasedOnDataModel()
    }
}

//MARK: Private
private extension DefaultCollectionViewCell {
    func setupView() {
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
    }
    
    func updateUIBasedOnDataModel() {
        guard let viewModel, let dataModel = viewModel.dataModel else { return }
        image.image = UIImage(named: dataModel.imageName)
        titleLabel.text = dataModel.title
    }
}
