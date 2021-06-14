//
//  SaveLandmarkViewModel.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import Foundation

enum SaveLandmarkCellType: String {
    case inputUsername
    case inputDescription
    case defaultType
}

protocol SaveLandmarkViewModelProviding {
    /// The title of SaveLandmarkViewController.
    var title: String { get }
    
    /// Sections of the tableView in SaveLandmarkViewController.
    var sections: [SaveLandmarkSection] { get }
    
    /// The value in username textfield.
    var username: String { get set }
    
    /// The value in description textfield.
    var description: String { get set }
    
    /// The value shows whether it is validated to save.
    var isFormValidated: Bindable<Bool> { get set }
}

class SaveLandmarkViewModel: SaveLandmarkViewModelProviding {
    // MARK: - Properties
    
    let title = "Save Landmark"
    var sections: [SaveLandmarkSection]
    var username: String = Strings.empty {
        didSet {
            validateForm()
        }
    }
    var description: String = Strings.empty {
        didSet {
            validateForm()
        }
    }
    var isFormValidated: Bindable<Bool> = Bindable<Bool>()
    
    // MARK: - Life cycle
    
    init() {
        let usernameSection = SaveLandmarkSection(title: "Username",
                                                  items: [InputUsernameItemViewModel()])
        let descriptionSection = SaveLandmarkSection(title: "Description",
                                                     items: [InputDescriptionItemViewModel()])
        sections = [usernameSection,
                    descriptionSection]
    }
    
    // MARK: - Private functions
    
    private func validateForm() {
        isFormValidated.value = (username == Strings.empty ||
                                    description == Strings.empty) ? false : true
    }
}


