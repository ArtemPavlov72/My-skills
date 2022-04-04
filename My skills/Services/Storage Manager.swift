//
//  Storage Manager.swift
//  My skills
//
//  Created by Artem Pavlov on 26.03.2022.
//

import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MySkillsCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    init() {
        viewContext = persistentContainer.viewContext
    }
    
    //MARK: - Private Methods of TaskList
    func fetchTaskList(completion: (Result<[TaskList], Error>) -> Void) {
        let fetchRequest = TaskList.fetchRequest()
        
        do {
            let tasksLists = try viewContext.fetch(fetchRequest)
            completion(.success(tasksLists))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func saveTasklist(nameOfTaskList: String) {
        let taskList = TaskList(context: viewContext)
        taskList.title = nameOfTaskList
        saveContext()
    }
    
    func editTaskList(_ taskList: TaskList, newTaskList: String) {
        taskList.title = newTaskList
        saveContext()
    }
    
    func deleteTaskList(_ tasklist: TaskList) {
        viewContext.delete(tasklist)
        saveContext()
    }
    
    //MARK: - Private Methods of Task
    
    func saveTask(_ taskName: String, to taskListed: TaskList) {
        let task = Task(context: viewContext)
        
        task.title = taskName
        task.taskList = taskListed
        
        saveContext()
    }
    
    func editData(_ task: Task, newTask: String) {
        task.title = newTask
        saveContext()
    }
    
    func deleteData(_ task: Task) {
        viewContext.delete(task)
        saveContext()
    }

    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
