//
//  SaveLandmarkItemViewModel.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import Foundation

protocol SaveLandmarkItemViewModelProviding {
    
    /// The delegate in SaveLandmarkItemViewModel. Mainly get used when the item is interacted.
    var delegate: SaveLandmarkViewModelProviding? { get set }
    
    /// The type of SaveLandmarkCell.
    var type: SaveLandmarkCellType { get }
    
    /// The placeholder in textfield.
    var placeholder: String { get }
    
    /// The value in textfield.
    var input: String { get set }
}

struct SaveLandmarkItemViewModel: SaveLandmarkItemViewModelProviding {
    var delegate: SaveLandmarkViewModelProviding?
    
    var input: String = Strings.empty
    
    let type: SaveLandmarkCellType = .defaultType
    let placeholder: String = Strings.empty
}
