//
//  UserDefaultsExtension.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import Foundation

extension UserDefaults {
    // MARK: - Open functions
    
    /// Saves a custom object into UserDefaults
    /// - Parameters:
    ///   - object: The object that needs to be saved.
    ///   - key: The key used to fetch the object.
    func save<T: Encodable>(customObject object: T, inKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            self.set(encoded, forKey: key)
        }
    }
    
    /// Retrieves an object from the key passed in.
    /// - Parameters:
    ///   - type: The type of the object to be retrieved.
    ///   - key: The key passed in when saving the object.
    /// - Returns: An object of the type, which was saved by the key.
    func retrieve<T: Decodable>(object type: T.Type, fromKey key: String) -> T? {
        if let data = self.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                return object
            } else {
                print("Couldnt decode object")
                return nil
            }
        } else {
            print("Couldnt find key: \(key)")
            return nil
        }
    }
    
    /// Retrieves an object from the key passed in and then delete it.
    /// - Parameters:
    ///   - type: The type of the object to be retrieved.
    ///   - key: The key passed in when saving the object.
    /// - Returns: An object of the type, which was saved by the key.
    func retrieveAndDelete<T: Decodable>(object type: T.Type, fromKey key: String) -> T? {
        if let data = self.data(forKey: key) {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(type, from: data) {
                UserDefaults.standard.removeObject(forKey: key)
                return object
            } else {
                print("Couldnt decode object")
                return nil
            }
        } else {
            print("Couldnt find key: \(key)")
            return nil
        }
    }
    
    
    // MARK:- Static functions
    static func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
