//
//  CircleButton.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import UIKit

enum CircleButtonImage: String {
    case recordCircle = "record.circle"
    case rCircle = "r.circle"
}

/// The circle button in this project.
final class CircleButton: UIButton {
    
    init(image: CircleButtonImage) {
        super.init(frame: .zero)
        let configuration = UIImage.SymbolConfiguration(pointSize: 50)
        let image = UIImage(systemName: image.rawValue,
                            withConfiguration: configuration)
        setImage(image, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
