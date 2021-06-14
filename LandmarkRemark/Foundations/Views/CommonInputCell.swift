//
//  CommonInputCell.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import UIKit

/// This is the common input cell used in table view.
class CommonInputCell: UITableViewCell {
    // MARK: - Properties
    
    lazy var textField: IndentedTextField = IndentedTextField(padding: ConstraintConstants.Padding.large)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        self.textField.addTarget(self, action: #selector(onInputChanged), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onInputChanged(){ }
}
