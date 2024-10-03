//
//  LandscapeCollectionViewCell.swift
//  DiffableDataSourceSamples
//
//  Created by Maryam Chaharsooghi on 03/10/2024.
//

import UIKit

protocol LandscapeCollectionCellDelegate: AnyObject {}

final class LandscapeCollectionViewModel: DefaultCollectionViewModelProtocol {
    
    var model: FamousPlace
    weak var delegate: LandscapeCollectionCellDelegate?
    
    init(model: FamousPlace, delegate: AnyObject? = nil) {
        self.model = model
        self.delegate = delegate as? LandscapeCollectionCellDelegate
    }
    
    func getDataModel() -> FamousPlace {
        model
    }
}

final class LandscapeCollectionViewCell: UICollectionViewCell {
    //MARK: - Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    //MARK: - Properties
    var viewModel: LandscapeCollectionViewModel?

    //MARK: - Outlets
    @IBOutlet weak private(set) var image: UIImageView!
    @IBOutlet weak private(set) var titleLabel: UILabel!
}

//MARK: - Methods
//MARK: Public
extension LandscapeCollectionViewCell {
    func configCell(_ viewModel: LandscapeCollectionViewModel) {
        self.viewModel = viewModel
        updateUIBasedOnDataModel()
    }
}

//MARK: Private
private extension LandscapeCollectionViewCell {
    func setupView() {
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
    }
    
    func updateUIBasedOnDataModel() {
        guard let viewModel else { return }
        let dataModel = viewModel.getDataModel()
        image.image = UIImage(named: dataModel.imageName)
        titleLabel.text = dataModel.title
    }
}
