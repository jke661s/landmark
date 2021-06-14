//
//  InputDescriptionItemViewModel.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import Foundation

class InputDescriptionItemViewModel: SaveLandmarkItemViewModelProviding {
    // MARK: - Properties
    
    var delegate: SaveLandmarkViewModelProviding?
    var input: String = Strings.empty {
        didSet {
            delegate?.description = input
        }
    }
    let type: SaveLandmarkCellType = .inputDescription
    let placeholder: String = "Enter description"
}
