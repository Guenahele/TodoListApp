//
//  NewTaskButton.swift
//  TodoListApp
//
//  Created by apprenant02 on 04/01/2023.
//

import SwiftUI

struct NewTaskButton: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View
    {
        VStack
        {
            Spacer()
            HStack
            {
                Spacer()
                NavigationLink(destination: TaskEditView(passedTaskItem: nil, initialDate: Date()).environmentObject(dateHolder))
                {
                    Text("+ Nouvelle tâche")
                        .font(.headline)
                }
                .padding(15)
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(15)
                .padding(15)
                .shadow(color: .black.opacity(0.3),radius:3, x:3, y:3)
            }
        }
    }
}

struct NewTaskButton_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskButton()
    }
}
