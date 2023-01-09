//
//  TaskEditBView.swift
//  TodoListApp
//
//  Created by apprenant02 on 04/01/2023.
//

import SwiftUI

struct TaskEditView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    
    @State var selectedTaskItem: Item?
    @State var name: String
    @State var comment: String
    @State var dueDate: Date
    @State var scheduleTime: Bool
    
    let notified = NotManager()
    
    
    init(passedTaskItem: Item?, initialDate: Date) {
        if let Item = passedTaskItem {
            _selectedTaskItem = State(initialValue: Item)
            _name = State(initialValue: Item.name ?? "")
            _comment = State(initialValue: Item.comment ?? "")
            _dueDate = State(initialValue: Item.dueDate ?? initialDate)
            _scheduleTime = State(initialValue: Item.scheduleTime)
        }
        else {
            _name = State(initialValue: "")
            _comment = State(initialValue: "")
            _dueDate = State(initialValue: initialDate)
            _scheduleTime = State(initialValue: false)
        }
    }
    
    var body: some View
    {
        Form
        {
            Section(header: Text("Tâche à faire").foregroundColor(.black))
            {
                TextField("Intitulé", text: $name)
                    .font(.custom("Chalkduster", size: 18))
                TextField("Description", text: $comment)
            }
           
            Section(header: Text("A terminer pour").foregroundColor(.black))
            {
                Toggle("Horaire précis", isOn: $scheduleTime)
                DatePicker("Date butoire", selection: $dueDate, displayedComponents: displayComps())
            }
            if selectedTaskItem?.isCompleted() ?? false
            {
                Section(header: Text("Terminé"))
                {
                Text(selectedTaskItem?.timestamp?.formatted(date: .abbreviated, time: .shortened) ?? "")
                        .foregroundColor(.green)
                }
            }
            
            Section()
            {
                Button("Programmer un rappel pour date échue"){
                    notified.sendNotification(date: dueDate, type: "date", title: name, body: "Reminder Task")
                }
                    .foregroundColor(.gray)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            
            Section()
            {
                Button("Enregistrer", action: saveAction)
                    .foregroundColor(.gray)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    func displayComps() -> DatePickerComponents{
        return scheduleTime ? [.hourAndMinute, .date] : [.date]
    }
    
    func saveAction(){
        withAnimation {
            if selectedTaskItem == nil {
                selectedTaskItem = Item(context: viewContext)
            }
            
            selectedTaskItem?.created = Date()
            selectedTaskItem?.name = name
            selectedTaskItem?.dueDate = dueDate
            selectedTaskItem?.scheduleTime = scheduleTime
            
            dateHolder.saveContext(viewContext)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(passedTaskItem: Item(), initialDate: Date())
    }
}
