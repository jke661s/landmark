//
//  Bindable.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import Foundation

class Bindable<T> {
    
    typealias Observer = ((T?) -> Void)
    
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: Observer?
    
    func bind(observer: @escaping Observer) {
        self.observer = observer
    }
}
