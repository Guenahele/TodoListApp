//
//  TaskCell.swift
//  TodoListApp
//
//  Created by apprenant02 on 04/01/2023.
//

import SwiftUI

struct TaskCell: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var passedTaskItem : Item
    
    var body: some View
    {
       HStack
        {
            CheckBoxView(passedTaskItem: passedTaskItem).environmentObject(dateHolder)
            
            Text(passedTaskItem.name ?? "")
                .padding(.horizontal)
                .font(.custom("Chalkduster", size: 18))
            
            if !passedTaskItem.isCompleted() && passedTaskItem.scheduleTime
            {
                Spacer()
                Text(passedTaskItem.dueDateTimeOnly())
                    .font(.footnote)
                    .foregroundColor(passedTaskItem.overDueColor())
                    .padding(.horizontal)
            }
            
        }
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(passedTaskItem: Item())
    }
}
