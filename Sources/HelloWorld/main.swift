import Kitura
import HeliumLogger

HeliumLogger.use()

let router = Router()
let itemStorage:ItemStorage = ItemMySQLStorage()

router.all(middleware: BodyParser())

// http://localhost:8080/
router.get("/") { request, response, next in
    
    response.send("Hello World!")
    
    next()
}

// http://localhost:8080/items
router.get("/items") { request, response, next in
    
    // query for all items
    guard let items = itemStorage.getAllItems() else {
        response.status(.internalServerError)
        return
    }
    
    response.status(.OK)
    response.send(json: items.map { item -> [AnyHashable:Any] in
        return ["id": item.id,
                "title": item.title]
    })
    
    next()
}

// create new item
router.post("/items") { request, response, next in
    
    guard let title = request.body?.asJSON?["title"].string else {
            response.status(.badRequest)
            return
    }
    
    guard let newItem = itemStorage.addItem(title: title) else {
        response.status(.internalServerError)
        return
    }

    response.status(.OK)
    response.send(json: newItem.dictionary)
    
    next()
}

// http://localhost:8080/items/?id=36bc9921-c6ae-4ef4-bd61-a5864f3f7718
router.get("/items/") { request, response, next in
    
    guard let id = request.queryParameters["id"] else {
            response.status(.badRequest)
            return
    }
    
    guard let item = itemStorage.getItemWith(id: id) else {
        response.status(.notFound)
        return
    }
    
    response.status(.OK)
    response.send(json: item.dictionary)
    
    next()
}

// (updated title of item) http://localhost:8080/items/?id=36bc9921-c6ae-4ef4-bd61-a5864f3f7718
router.post("/items/") { request, response, next in
    
    guard let id = request.queryParameters["id"],
          let title = request.body?.asJSON?["title"].string else {
            response.status(.badRequest)
            return
    }
    
    guard let item = itemStorage.getItemWith(id: id) else {
            response.status(.notFound)
            return
    }
    
    guard let updatedItem = itemStorage.updateItem(id: id, newTitle: title) else {
        response.status(.internalServerError)
        return
    }
    
    response.status(.OK)
    response.send(json: updatedItem.dictionary)
    
    next()
}

//delete item
router.delete("/items/") { request, response, next in
    
    guard let id = request.queryParameters["id"] else {
            response.status(.badRequest)
            return
    }
    
    guard let item = itemStorage.getItemWith(id: id) else {
        response.status(.notFound)
        return
    }
    
    itemStorage.deleteItem(id: item.id)
    
    response.status(.OK)
    next()
}


Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()
