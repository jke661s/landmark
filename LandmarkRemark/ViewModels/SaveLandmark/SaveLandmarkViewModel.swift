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
    
    /// The action when save button is tapped.
    func onSaveButtonTapped()
}

class SaveLandmarkViewModel: SaveLandmarkViewModelProviding {
    // MARK: - Properties
    
    let title = Strings.Title.saveLandmark
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
    
    private let location: Location!
    private let db: DatabaseServiceProviding!
    
    // MARK: - Life cycle
    
    init(location: Location,
         db: DatabaseServiceProviding = DatabaseService.shared) {
        let usernameSection = SaveLandmarkSection(title: Strings.Title.username,
                                                  items: [InputUsernameItemViewModel()])
        let descriptionSection = SaveLandmarkSection(title: Strings.Title.description,
                                                     items: [InputDescriptionItemViewModel()])
        sections = [usernameSection,
                    descriptionSection]
        self.location = location
        self.db = db
    }
    
    // MARK: - Private functions
    
    private func validateForm() {
        isFormValidated.value = (username == Strings.empty ||
                                    description == Strings.empty) ? false : true
    }
    
    // MARK: - SaveLandmarkViewModelProviding conformance
    
    func onSaveButtonTapped() {
        let landmark = Landmark(location: location,
                                description: description,
                                username: username)
        db.save(landmark)
    }
}


