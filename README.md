# ACRealm

## Create model
```
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
```
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

## Then create extension LocalMappable for the object
```
extension BarObject: LocalMappable {
    
    public func mapEntityToDomain() -> AnyObject {
               BarModel(id: id,
                        bar: bar,
                        foo: foo)
    }
    
    public func mapEntityFromDomain(data: AnyObject) {
        guard let model = data as? BarModel else { return }
                
        id = model.id
        bar = model.bar
        foo = model.foo
    }
    
}
```

## Create repository with class DBRepository 
```
class BarRepository: DBRepository<BarObject, BarModel> {
    ...
}
```
or
```
let barRepository = DBRepository<BarObject, BarModel>()
```

## And you can use one for everything
```
let repository = BarRepository()

let models = repository.getModels()

let newModel = BarModel(id: "some id",
                        bar: 123,
                        foo: 456)

repository.save(newModel)

let oldModel = repository.getModel(by: "some id")

repository.delete(oldModel)
```
