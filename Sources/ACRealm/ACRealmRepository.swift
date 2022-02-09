//
//  ACRealmRepository.swift
//
//  Created by Кирилл Романенко on 09.02.2022.
//

import Foundation
import RealmSwift

open class ACRealmRepository<ObjectType: ACRealmLocalMappable> {
    
    public lazy var realmService = ACRealmService()
    
    public init() {}
    
    public func getModels() -> [ObjectType.ModelType] {
        realmService.getObjects(ObjectType.self).compactMap { $0.mapToModel() }
    }
    
    public func getModel(by key: String) -> ObjectType.ModelType? {
        realmService.getObject(ObjectType.self, with: key)?.mapToModel()
    }
    
    public func save(_ model: ObjectType.ModelType) {
        let object = ObjectType()
        object.mapFromModel(model)
        realmService.save(object)
    }
    
    public func save(_ models: [ObjectType.ModelType]) {
        var objects: [ObjectType] = []
        
        models.forEach { model in
            let object = ObjectType()
            object.mapFromModel(model)
            objects.append(object)
        }
        
        realmService.save(objects)
    }
    
    public func delete(by key: String, completion: (() -> Void)? = nil) {
        realmService.deleteObject(ObjectType.self, with: key, completion: completion)
    }
    
    public func delete(_ model: ObjectType.ModelType, completion: (() -> Void)? = nil) {
        let object = ObjectType()
        object.mapFromModel(model)
        realmService.deleteObject(object, completion: completion)
    }
    
    public func clearDB(completion: (() -> Void)? = nil) {
        realmService.deleteObjects(ObjectType.self, completion: completion)
    }
    
}
