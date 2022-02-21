//
//  ACRealmService.swift
//
//  Created by Кирилл Романенко on 09.02.2022.
//

import Foundation
import RealmSwift

open class ACRealmService {
    
    open func getObjects<T: Object>(_ type: T.Type) -> [T] {
        if let realm = try? Realm() {
            return Array(realm.objects(type))
        }
        print("[ACRealmService] - [\(#function)] - error with try Realm")
        return []
    }
    
    open func getObject<T: Object>(_ type: T.Type, with key: String) -> T? {
        if let realm = try? Realm() {
            return realm.object(ofType: type, forPrimaryKey: key)
        }
        print("[ACRealmService] - [\(#function)] - error with try Realm")
        return nil
    }
    
    open func deleteObject<T: Object>(_ object: T, completion: ACRealmSuccessHandler?) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(object)
                completion?(true)
            }
        } catch let error {
            completion?(false)
            print("[ACRealmService] - [\(#function)] - error:", error)
        }
    }
    
    open func deleteObject<T: Object>(_ type: T.Type, with key: String, completion: ACRealmSuccessHandler?) {
        do {
            let realm = try Realm()
            try realm.write {
                if let object = realm.object(ofType: type, forPrimaryKey: key) {
                    realm.delete(object)
                    completion?(true)
                } else {
                    completion?(false)
                }
            }
        } catch let error {
            completion?(false)
            print("[ACRealmService] - [\(#function)] - error:", error)
        }
    }
    
    open func deleteObjects<T: Object>(_ type: T.Type, completion: ACRealmSuccessHandler?) {
        do {
            let realm = try Realm()
            try realm.write {
                let objects = realm.objects(T.self)
                realm.delete(objects)
                completion?(true)
            }
        } catch let error {
            completion?(false)
            print("[ACRealmService] - [\(#function)] - error:", error)
        }
    }
    
    open func save<T: Object>(_ object: T, completion: ACRealmSuccessHandler?) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object, update: .modified)
                completion?(true)
            }
        }
        catch {
            completion?(false)
            print("[ACRealmService] - [\(#function)] - error:", error)
        }
    }
    
    open func save<T: Object>(_ objects: [T], completion: ACRealmSuccessHandler?) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(objects, update: .modified)
                completion?(true)
            }
        }
        catch {
            completion?(false)
            print("[ACRealmService] - [\(#function)] - error:", error)
        }
    }
    
    open func modify(block: () -> Void) {
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
