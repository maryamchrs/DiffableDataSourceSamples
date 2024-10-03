//
//  MemoryCollectionViewCell.swift
//  CollectionViewExample
//
//  Created by Maryam Chaharsooghi on 16/09/2024.
//

import UIKit

protocol MemoryCollectionViewCellDelegate: AnyObject {
    func favoriteButtonTapped(dataModel: MemoryItem)
}

final class MemoryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    //MARK: - Properties
    var viewModel: MemoryCollectionViewModel?
    
    //MARK: - Outlets
    @IBOutlet private(set) weak var imageIcon: UIImageView!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private(set) weak var favoriteButton: UIButton!
}

//MARK: - Methods
//MARK: Public
extension MemoryCollectionViewCell {
    func setViewModel(_ viewModel: MemoryCollectionViewModel) {
        self.viewModel = viewModel
        updateUIBasedOnDataModel()
    }
}

//MARK: Private
private extension MemoryCollectionViewCell {
    func setupView() {
        contentView.layer.masksToBounds = true
        imageIcon.layer.masksToBounds = true
        imageIcon.layer.cornerRadius = 8
        favoriteButton.tintColor = .red
        favoriteButton.setTitle("", for: .normal)
        if #available(iOS 15.0, *) {
            favoriteButton.configuration = nil
        }
    }
    
    func updateUIBasedOnDataModel() {
        guard let viewModel else { return }
        let dataModel = viewModel.getDataModel()
        imageIcon.image = UIImage(named: dataModel.imageName)
        descriptionLabel.text = dataModel.title
    }
}

//MARK: - Actions
private extension MemoryCollectionViewCell {
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        guard let dataModel = viewModel?.getDataModel() else { return }
        viewModel?.delegate?.favoriteButtonTapped(dataModel: dataModel)
    }
}
