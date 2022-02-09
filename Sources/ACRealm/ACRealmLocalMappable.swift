//
//  ACRealmLocalMappable.swift
//
//  Created by Кирилл Романенко on 09.02.2022.
//

import Foundation
import RealmSwift

public protocol ACRealmLocalMappable: Object {
    associatedtype ModelType
    
    func mapFromModel(_ model: ModelType?)
    func mapToModel() -> ModelType?
}
