//
//  IndentedTextField.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import UIKit

/// This is the indented text field used in the project.
final class IndentedTextField: UITextField {
    // MARK: - Properties
    
    private let padding: CGFloat
    
    // MARK: - Life cycle
    
    init(placeholder: String? = nil,
         padding: CGFloat = 0,
         cornerRadius: CGFloat = 0,
         keyboardType: UIKeyboardType = .default,
         backgroundColor: UIColor = .clear,
         isSecureTextEntry: Bool = false) {
        self.padding = padding
        super.init(frame: .zero)
        self.placeholder = placeholder
        layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

