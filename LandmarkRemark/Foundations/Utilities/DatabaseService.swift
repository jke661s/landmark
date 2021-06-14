//
//  DatabaseService.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import Foundation
import RealmSwift

protocol DatabaseServiceProviding {
    func save<T: Object>(_ object: T)
    func retrieve<T: Object>(object type: T.Type) -> Results<T>?
    func update<T: Object>(_ object: T, updateHandler: (T) -> Void)
    func deleteAll()
}

final class DatabaseService: DatabaseServiceProviding {
    static let shared: DatabaseService = .init()
    
    private let realm = try? Realm()
    
    func save<T: Object>(_ object: T) {
        try? realm?.write {
            realm?.add(object)
        }
    }
    
    func retrieve<T: Object>(object type: T.Type) -> Results<T>? {
        realm?.objects(type)
    }
    
    func update<T: Object>(_ object: T, updateHandler: (T) -> Void) {
        try? realm?.write {
            updateHandler(object)
        }
    }
    
    func deleteAll() {
        try? realm?.write {
            realm?.deleteAll()
        }
    }
}
