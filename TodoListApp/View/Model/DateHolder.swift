//
//  DateHolder.swift
//  TodoListApp
//
//  Created by apprenant02 on 04/01/2023.
//

import SwiftUI
import CoreData

class DateHolder: ObservableObject
{
    @Published var date = Date()
    @Published var Items: [Item] = []
    
    let calendar: Calendar = Calendar.current
    
    func moveDate(_ days: Int,_ context : NSManagedObjectContext)
    {
        date = calendar.date(byAdding: .day, value: days, to: date)!
        refreshItems(context)
    }
    
    init(_ context: NSManagedObjectContext)
    {
        refreshItems(context)
    }
    
    
    func refreshItems(_ context: NSManagedObjectContext)
    {
        Items = fetchItems(context)
    }
    
    
    
    func fetchItems(_ context: NSManagedObjectContext) -> [Item]
    {
        do
        {
            return try context.fetch(dailyTasksFetch()) as [Item]
        }
        catch let error
        {
            fatalError("Unresolved error \(error)")
        }
    }
    
    func dailyTasksFetch() -> NSFetchRequest<Item>
    {
        let request = Item.fetchRequest()
        
        request.sortDescriptors = sortOrder()
        request.predicate = predicate()
        return request
    }
    
    private func sortOrder()-> [NSSortDescriptor]
    {
        let timestampSort  = NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)
        let timeSort  = NSSortDescriptor(keyPath: \Item.scheduleTime, ascending: true)
        let dueDateSort  = NSSortDescriptor(keyPath: \Item.dueDate, ascending: true)
        
        return [timestampSort, timeSort, dueDateSort]
    }
    
    private func predicate() -> NSPredicate
    {
        let start = calendar.startOfDay(for: date)
        let end = calendar.date(byAdding:  .day,value: 1, to: start)
        return NSPredicate(format: "dueDate >= %@ AND dueDate < %@", start as NSDate, end! as NSDate)
    }
    
    
    func saveContext(_ context: NSManagedObjectContext)
    {
        do {
            try context.save()
            refreshItems(context)
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
