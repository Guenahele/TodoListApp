//
//  TodoListAppApp.swift
//  TodoListApp
//
//  Created by apprenant02 on 04/01/2023.
//

import SwiftUI

@main
struct TodoListAppApp: App {
    
    let persistenceController = PersistenceController.shared
    
 //   private let notificationManager = NotificationManager()

    init() {

    //    setupNotifications()
    }

    var body: some Scene {
        WindowGroup {
            let context = persistenceController.container.viewContext
            let dateHolder = DateHolder(context)
            
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dateHolder)
    }
}



//struct LocalNotificationsApp: App {
//    private let notificationManager = NotificationManager()
//
//    init() {
//
//        setupNotifications()
//    }

//    var body: some Scene {
//        WindowGroup {
//            ContentView(notificationManager: notificationManager)
//        }
//    }

//   private func setupNotifications() {
//        notificationManager.notificationCenter.delegate = notificationManager
//        notificationManager.handleNotification = handleNotification
//
//        requestNotificationsPermission()
//    }

//    private func handleNotification(notification: UNNotification) {
//        print("<<<DEV>>> Notification received: \(notification.request.content.userInfo)")
//    }

//    private func requestNotificationsPermission() {
//        notificationManager.requestPermission(completionHandler: { isGranted, error in
//            if isGranted {
//                // handle granted success
//            }

//            if let _ = error {
//                // handle error
//
//                return
//            }
//        })
//    }

}
