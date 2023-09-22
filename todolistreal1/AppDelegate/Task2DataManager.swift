import CoreData
import UIKit

class Task2DataManager{
    static let shared: Task2DataManager = Task2DataManager()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "Task2"
    
    func getTaskDatas(ascending: Bool = false) -> [Task2] {
        var models: [Task2] = [Task2]()
        
        if let context = context {
            let idSort: NSSortDescriptor = NSSortDescriptor(key: "createDate", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [idSort]
            do {
                if let fetchResult: [Task2] = try context.fetch(fetchRequest) as? [Task2] {
                    models = fetchResult
                }
            }catch let error as NSError{
                print("Could not fetch : \(error), \(error.userInfo)")
            }
        }
        return models
    }
    
    
    func getCompletedTask2(ascending: Bool = false) -> [Task2] {
        var models: [Task2] = [Task2]()
        
        if let context = context {
            let idSort: NSSortDescriptor = NSSortDescriptor(key: "createDate", ascending: ascending)
            let filterCompleted = NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
            let fetchRequest: NSFetchRequest<NSManagedObject>
            = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [idSort]
            do {
                if let fetchResult: [Task2] = try context.fetch(fetchRequest) as? [Task2] {
                    models = fetchResult
                }
            } catch let error as NSError {
                print("Could not fetch: \(error), \(error.userInfo)")
            }
        }
        return models
    }
    
    func saveTaskData(title: String,
                      createDate: Date,
                      isCompleted: Bool = false,
                      onSuccess: ((Bool) -> Void)? = nil) {
        if let context = context,
           let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: modelName, in: context) {
            if let taskData: Task2 = NSManagedObject(entity: entity, insertInto: context) as? Task2 {
                taskData.id = UUID()
                taskData.title = title
                taskData.createDate = createDate
                taskData.modifyDate = createDate
                taskData.isCompleted = isCompleted
                contextSave { success in
                    onSuccess?(success)
                    
                }
            }
        }
    }
    
    func deleteTaskData(id: UUID, onSuccess: ((Bool) -> Void)? = nil) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id)
        
        do {
            if let results: [Task2] = try context?.fetch(fetchRequest) as? [Task2] {
                if results.count != 0 {
                    context?.delete(results[0])
                }
            }
        } catch let error as NSError{
            print("Could not fatch: \(error), \(error.userInfo)")
            onSuccess?(false)
        }
        
        contextSave{ success in
            onSuccess?(success)
        }
    }
    
    func modifyTaskData(id: UUID, title: String, isCompleted: Bool, modifyDate: Date = Date(), onSuccess: ((Bool) -> Void)? = nil) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequest(id: id)
        
        do {
            if let results: [Task2] = try context?.fetch(fetchRequest) as? [Task2] {
                if results.count != 0{
                    let result = results[0]
                    result.modifyDate = modifyDate
                    result.title = title
                    result.isCompleted = isCompleted
                    
                    contextSave { success in
                        onSuccess?(success)
                    }
                }
            }
        } catch let error as NSError {
            print("Could not fatch: \(error), \(error.userInfo)")
            onSuccess?(false)
        }
    }
}
    
    extension Task2DataManager{
        fileprivate func filteredRequest(id: UUID) -> NSFetchRequest<NSFetchRequestResult> {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult>
                = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
            fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
            return fetchRequest
        }
        
        fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
            do {
                try context?.save()
                onSuccess(true)
            } catch let error as NSError {
                print("Could not save : \(error), \(error.userInfo)")
                onSuccess(false)
            }
        }
}
