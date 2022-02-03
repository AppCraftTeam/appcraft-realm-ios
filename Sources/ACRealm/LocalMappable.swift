//
//  LocalMappable.swift
//  StopWatchApp
//
//  Created by Кирилл Романенко on 01.02.2022.
//

import Foundation

public protocol LocalMappable {
    func mapEntityToDomain() -> AnyObject
    func mapEntityFromDomain(data: AnyObject)
}

public extension LocalMappable {
    
    func mapEntityToDomain() -> AnyObject {
        NSLog("[\(self)] - Error: Entity to domain mapper not implemented")
        
        return self as AnyObject
    }
    
    func mapEntityFromDomain(data: AnyObject) {
        NSLog("[\(self)] - Error: Domain to entity mapper not implemented")
    }
    
}
