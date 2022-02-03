//
//  DBRepository.swift
//  ACRealm
//
//  Created by Кирилл Романенко on 02.02.2022.
//

import Foundation
import RealmSwift

open class DBRepository<O: Object & LocalMappable, M: AnyObject> {
    
    public lazy var realmService = RealmService()
    
    public init() {}
    
    public func getModels() -> [M] {
        realmService.getObjects(O.self).compactMap { $0.mapEntityToDomain() as? M }
    }
    
    public func getModel(by key: String) -> M? {
        realmService.getObject(O.self, with: key)?.mapEntityToDomain() as? M
    }
    
    public func save(_ model: M) {
        let object = O()
        object.mapEntityFromDomain(data: model)
        realmService.save(object)
    }
    
    public func save(_ models: [M]) {
        var objects: [O] = []
        
        models.forEach { model in
            let object = O()
            object.mapEntityFromDomain(data: model)
            objects.append(object)
        }
        
        realmService.save(objects)
    }
    
    public func delete(by key: String, completion: (() -> Void)? = nil) {
        realmService.deleteObject(O.self, with: key, completion: completion)
    }
    
    public func delete(_ model: M, completion: (() -> Void)? = nil) {
        let object = O()
        object.mapEntityFromDomain(data: model)
        realmService.deleteObject(object, completion: completion)
    }
    
    public func clearDB(completion: (() -> Void)? = nil) {
        realmService.deleteObjects(O.self, completion: completion)
    }
    
}
