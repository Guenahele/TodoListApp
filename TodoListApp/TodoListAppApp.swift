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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}