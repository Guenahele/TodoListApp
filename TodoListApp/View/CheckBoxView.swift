//
//  CheckBoxView.swift
//  TodoListApp
//
//  Created by apprenant02 on 04/01/2023.
//

import SwiftUI

struct CheckBoxView: View
{
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem: Item
    
    var body: some View {
        
        Image(systemName: passedTaskItem.isCompleted() ? "checkmark.circle.fill" : "circle")
            .foregroundColor(passedTaskItem.isCompleted() ? .green : .secondary)
            .onTapGesture {
                withAnimation
                {
                    if !passedTaskItem.isCompleted()
                    {
                        passedTaskItem.timestamp = Date()
                        dateHolder.saveContext(viewContext)
                    }
                }
            }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(passedTaskItem: Item())
    }
}
