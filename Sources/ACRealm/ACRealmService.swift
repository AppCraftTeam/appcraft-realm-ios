//
//  ACRealmService.swift
//
//  Created by Кирилл Романенко on 09.02.2022.
//

import Foundation
import RealmSwift

open class ACRealmService {
    
    public func getObjects<T: Object>(_ type: T.Type) -> [T] {
        if let realm = try? Realm() {
            return Array(realm.objects(type))
        }
        return []
    }
    
    public func getObject<T: Object>(_ type: T.Type, with key: String) -> T? {
        if let realm = try? Realm() {
            return realm.object(ofType: type, forPrimaryKey: key)
        }
        return nil
    }
    
    public func deleteObject<T: Object>(_ object: T, completion: (() -> Void)?) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(object)
                completion?()
            }
        } catch let error {
            print("[ACRealmService] - [\(#function)] - error:", error)
        }
    }
    
    public func deleteObject<T: Object>(_ type: T.Type, with key: String, completion: (() -> Void)?) {
        do {
            let realm = try Realm()
            try realm.write {
                if let object = realm.object(ofType: type, forPrimaryKey: key) {
                    realm.delete(object)
                    completion?()
                }
            }
        } catch let error {
            print("[ACRealmService] - [\(#function)] - error:", error)
        }
    }
    
    public func deleteObjects<T: Object>(_ type: T.Type, completion: (() -> Void)?) {
        do {
            let realm = try Realm()
            try realm.write {
                let objects = realm.objects(T.self)
                realm.delete(objects)
                completion?()
            }
        } catch let error {
            print("[ACRealmService] - [\(#function)] - error:", error)
        }
    }
    
    public func save<T: Object>(_ object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object, update: .modified)
            }
        }
        catch {
            print("[ACRealmService] - [\(#function)] - error:", error)
        }
    }
    
    public func save<T: Object>(_ objects: [T]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(objects, update: .modified)
            }
        }
        catch {
            print("[ACRealmService] - [\(#function)] - error:", error)
        }
    }
    
    public func modify(block: () -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                block()
            }
        }
        catch {
            print("[ACRealmService] - [\(#function)] - error:", error)
        }
    }
    
}
