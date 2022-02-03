//
//  RealmService.swift
//  StopWatchApp
//
//  Created by Кирилл Романенко on 12.02.2021.
//

import Foundation
import RealmSwift

open class RealmService {
    
    private let realm = try! Realm()
    
    public func getObjects<T: Object>(_ type: T.Type) -> [T] {
        Array(realm.objects(type))
    }
    
    public func getObject<T: Object>(_ type: T.Type, with key: String) -> T? {
        realm.object(ofType: type, forPrimaryKey: key)
    }
    
    public func deleteObject<T: Object>(_ type: T.Type, with key: String, completion: (() -> Void)?) {
        do {
            try realm.write {
                if let object = realm.object(ofType: type, forPrimaryKey: key) {
                    realm.delete(object)
                    completion?()
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    public func deleteObjects<T: Object>(_ type: T.Type, completion: (() -> Void)?) {
        do {
            try realm.write {
                let objects = realm.objects(T.self)
                realm.delete(objects)
                completion?()
            }
        } catch let error {
            print(error)
        }
    }
    
    public func save<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        }
        catch {
            print("error adding")
        }
    }
    
    public func save<T: Object>(_ objects: [T]) {
        do {
            try realm.write {
                realm.add(objects, update: .modified)
            }
        }
        catch {
            print("error adding")
        }
    }
    
    public func modify(block: () -> Void) {
        do {
            try realm.write {
                block()
            }
        }
        catch {
            print("error modifying")
        }
    }
    
}
