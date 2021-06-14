//
//  InputDescriptionCell.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import Foundation

final class InputDescriptionCell: CommonInputCell, SaveLandmarkCellProviding {
    // MARK: - Properties
    
    /// InputDescriptionItemViewModel
    private var viewModel: InputDescriptionItemViewModel?
    
    // MARK: - SaveLandmarkCellProviding conformance
    
    func update(viewModel: SaveLandmarkItemViewModelProviding) {
        if let viewModel = viewModel as? InputDescriptionItemViewModel {
            self.viewModel = viewModel
            self.textField.placeholder = viewModel.placeholder
        }
    }
    
    // MARK: - Override functions
    
    override func onInputChanged(){
        self.viewModel?.input = textField.text ?? Strings.empty
    }
}
