# ACRealm

## Installation

1. Go to `File` -> `Swift Packages` -> `Add Package Dependency...`
2. Then search for 
```
https://github.com/AppCraftTeam/appcraft-realm-ios.git
```
3. Select the SDK version that you want to use

## Create model
```swift
class BarModel {
    var id: String
    var bar: Int
    var foo: Int
    
    init(id: String,
         bar: Int,
         foo: Int) {
        self.id = id
        self.bar = bar
        self.foo = foo
    }
}
```

## Create object
```swift
@objcMembers
class BarObject: Object {
    dynamic var id: String = UUID().uuidString
    dynamic var bar: Int = 0
    dynamic var foo: Int = 0
    
    override class func primaryKey() -> String? {
        return #keyPath(id)
    }
}
```

## Then create extension ACRealmLocalMappable for the object
```swift
extension BarObject: ACRealmLocalMappable {

    associatedtype ModelType = BarModel
    
    public func mapToModel() -> ModelType? {
               BarModel(id: id,
                        bar: bar,
                        foo: foo)
    }
    
    public func mapFromModel(_ model: ModelType?) {
        guard let model = model else { return }
                
        id = model.id
        bar = model.bar
        foo = model.foo
    }
    
}
```

## Create repository with class ACRealmRepository 
```swift
class BarRepository: ACRealmRepository<BarObject> {
    ...
}
```
or
```swift
let barRepository = ACRealmRepository<BarObject>()
```

## And you can use one for everything
```swift
let repository = BarRepository()

let models = repository.getModels()

let newModel = BarModel(id: "some id",
                        bar: 123,
                        foo: 456)

repository.save(newModel)

let oldModel = repository.getModel(by: "some id")

repository.delete(oldModel)
```
