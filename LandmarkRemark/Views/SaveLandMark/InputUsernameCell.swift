//
//  InputUsernameCell.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import Foundation

final class InputUsernameCell: CommonInputCell, SaveLandmarkCellProviding {
    // MARK: - Properties
    
    /// InputUsernameItemViewModel
    private var viewModel: InputUsernameItemViewModel?
    
    // MARK: - SaveLandmarkCellProviding conformance
    
    func update(viewModel: SaveLandmarkItemViewModelProviding) {
        if let viewModel = viewModel as? InputUsernameItemViewModel {
            self.viewModel = viewModel
            self.textField.placeholder = viewModel.placeholder
        }
    }
    
    // MARK: - Override functions
    
    override func onInputChanged() {
        self.viewModel?.input = textField.text ?? Strings.empty
    }
}
