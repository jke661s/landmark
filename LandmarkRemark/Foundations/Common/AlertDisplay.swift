//
//  AlertDisplay.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import UIKit

typealias AlertActionHandler = (UIAlertAction) -> Void

/// The alert action used in this project.
enum LRAlertAction {
    case cancel
    case ok(actionHandler: AlertActionHandler?)
    
    private var title: String {
        switch self {
        case .cancel:
            return Strings.Generic.cancel
        case .ok:
            return Strings.Generic.ok
        }
    }
    
    private var handler: AlertActionHandler? {
        switch self {
        case .cancel:
            return nil
        case .ok(let actionHandler):
            return actionHandler
        }
    }
    
    /// The alert action that created depending on LRAlertAction.
    var alertAction: UIAlertAction {
        UIAlertAction(title: title,
                      style: .default,
                      handler: handler)
    }
}

/// The alert error type.
enum AlertErrorType {
    case genericError
    case noPermissionError(errorType: PermissionError, handler: AlertActionHandler?)
}

protocol AlertDisplay {
    /// To display generic error.
    func showGenericError()
    
    /// To display errors related to permissions.
    /// - Parameters:
    ///   - errorType: The values tells which permission has been denied.
    ///   - handler: The action handler.
    func showPermissionError(errorType: PermissionError, with handler: AlertActionHandler?)
}

extension AlertDisplay where Self: UIViewController {
    // MARK: - Conformance
    
    func showGenericError() {
        showAlert(.genericError)
    }
    
    func showPermissionError(errorType: PermissionError, with handler: AlertActionHandler?) {
        showAlert(.noPermissionError(errorType: errorType, handler: handler))
    }
    
    // MARK: - Private functions
    
    private func showAlert(_ alertErrorType: AlertErrorType) {
        switch alertErrorType {
        case .genericError:
            showAlert(title: Strings.Alert.Generic.title,
                      message: Strings.Alert.Generic.message,
                      actions: [.ok(actionHandler: nil)])
        case .noPermissionError(let errorType, let handler):
            switch errorType {
            case .location:
                showAlert(title: Strings.Alert.LocationPermission.title,
                          message: Strings.Alert.LocationPermission.message,
                          actions: [.cancel,
                                    .ok(actionHandler: handler)])
            default:
                // Currently we don't need any other permissions. Leave it for now.
                break
            }
        }
    }
    
    private func showAlert(title: String?,
                           message: String?,
                           actions: [LRAlertAction]?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        if let actions = actions {
            actions.forEach { alert.addAction($0.alertAction) }
        }
        present(alert, animated: true)
    }
}
