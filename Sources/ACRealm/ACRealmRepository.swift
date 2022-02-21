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
    
    open func getModels() -> [ObjectType.ModelType] {
        realmService.getObjects(ObjectType.self).compactMap { $0.mapToModel() }
    }
    
    open func getModel(by key: String) -> ObjectType.ModelType? {
        realmService.getObject(ObjectType.self, with: key)?.mapToModel()
    }
    
    open func save(_ model: ObjectType.ModelType,
                     completion: ACRealmSuccessHandler? = nil) {
        
        let object = ObjectType()
        object.mapFromModel(model)
        realmService.save(object, completion: completion)
    }
    
    open func save(_ models: [ObjectType.ModelType],
                     completion: ACRealmSuccessHandler? = nil) {
        
        var objects: [ObjectType] = []
        
        models.forEach { model in
            let object = ObjectType()
            object.mapFromModel(model)
            objects.append(object)
        }
        
        realmService.save(objects, completion: completion)
    }
    
    open func delete(by key: String,
                       completion: ACRealmSuccessHandler? = nil) {
        realmService.deleteObject(ObjectType.self, with: key, completion: completion)
    }
    
    open func delete(_ model: ObjectType.ModelType,
                       completion: ACRealmSuccessHandler? = nil) {
        
        let object = ObjectType()
        object.mapFromModel(model)
        realmService.deleteObject(object, completion: completion)
    }
    
    public func clearDB(completion: ACRealmSuccessHandler? = nil) {
        realmService.deleteObjects(ObjectType.self, completion: completion)
    }
    
}

