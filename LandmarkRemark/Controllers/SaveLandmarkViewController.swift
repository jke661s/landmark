//
//  SaveLandmarkViewController.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import UIKit
 
final class SaveLandmarkViewController: BaseViewController {
    private var location: Location!
    
    init(location: Location) {
        super.init()
        self.location = location
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
