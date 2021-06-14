//
//  SaveLandmarkCellProviding.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import Foundation

protocol SaveLandmarkCellProviding {
    /// Assigns view model to save land mark cell.
    /// - Parameter viewModel: The save land view model.
    func update(viewModel: SaveLandmarkItemViewModelProviding)
}
