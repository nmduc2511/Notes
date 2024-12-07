import RealmSwift

final class RealmManager {
    func add<T: Object>(_ object: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object)
        }
    }
    
    func update<T: Object>(_ object: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    func objects<T: Object>(_ type: T.Type) -> Results<T> {
        let realm = try! Realm()
        return realm.objects(type)
    }
    
    func delete<T: Object>(_ object: T) {
        let realm = try! Realm()
        realm.delete(object)
    }
    
    func deleteAll<T: Object>(_ type: T.Type) {
        let realm = try! Realm()
        let objects = realm.objects(type)
        realm.delete(objects)
    }
}
