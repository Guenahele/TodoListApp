//
//  ContentView.swift
//  TodoListApp
//
//  Created by apprenant02 on 04/01/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    //  let notificationManager: NotificationManager
    
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \Item.dueDate, ascending: true)],
    //        animation: .default)
    //    private var items: FetchedResults<Item>
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                DateScroller()
                    .padding()
                    .foregroundColor(.gray)
                    .environmentObject(dateHolder)
                
                ZStack
                {
                    List {
                        ForEach(dateHolder.Items)
                        { item in
                            NavigationLink(destination: TaskEditView(passedTaskItem: item, initialDate: Date()).environmentObject(dateHolder))
                            {
                                TaskCell(passedTaskItem: item).environmentObject(dateHolder)
                                //                                    .onAppear{ scheduleNotification(triggerDate: item.dueDate!, ItemComment: "\(item.name!) : \(item.comment!) the \(item.dueDate!)")
                                //                                    }
                            }
                        }
                        .onDelete(perform: deleteItems)
                        
                        
                        
                    }
                    NewTaskButton().environmentObject(dateHolder)
                    
                }     .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                .navigationTitle("List des tâches").foregroundColor(.black)
                .navigationBarTitle("").foregroundColor(.orange)
            }.onAppear{NotManager.instance.requestAuthorization()
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
        }
    }
    
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { dateHolder.Items[$0] }.forEach(viewContext.delete)
            
            dateHolder.saveContext(viewContext)
        }
    }
    
    
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    func scheduleNotification(triggerDate: Date, ItemComment: String) {
        let notificationId = UUID()
        let content = UNMutableNotificationContent()
        content.body = "Attention ! \(ItemComment)"
        content.sound = UNNotificationSound.default
        content.userInfo = [
            "notificationId": "\(notificationId)" // additional info to parse if need
        ]
        
        //            let trigger = UNCalendarNotificationTrigger(dateMatching: NotificationHelper.getTriggerDate(triggerDate: item.dueDate)!, //attention à la dueDate
        //                                                        repeats: false
        //            )
        //
        //            notificationManager.scheduleNotification(
        //                id: "\(notificationId)",
        //                content: content,
        //                trigger: trigger)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(notificationManager: notificationManager).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
