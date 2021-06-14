//
//  InputUsernameItemViewModel.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import Foundation

struct InputUsernameItemViewModel: SaveLandmarkItemViewModelProviding {
    // MARK: - Properties
    
    var delegate: SaveLandmarkViewModelProviding?
    var input: String = Strings.empty {
        didSet {
            delegate?.username = input
        }
    }
    let type: SaveLandmarkCellType = .inputUsername
    let placeholder: String = Strings.Placeholder.enterUserName
}
