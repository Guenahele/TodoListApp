//
//  DateScroller.swift
//  TodoListApp
//
//  Created by apprenant02 on 04/01/2023.
//

import SwiftUI

struct DateScroller: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
   // let background = Color(.orange)
    
    var body: some View
    {
        ZStack
        {
//            background
//                .ignoresSafeArea(.all)
        HStack
        {
            Spacer()
            Button(action: moveBack)
            {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .font(Font.title.weight(.bold))
                    .foregroundColor(.gray)
            }
            
            Text(dateFormatted())
                .font(.title)
                .foregroundColor(.black)
                .bold()
                .animation(.none)
                .frame(maxWidth: .infinity)
            
            Button(action: moveForward)
            {
                Image(systemName: "arrow.right")
                    .imageScale(.large)
                    .font(Font.title.weight(.bold))
                    .foregroundColor(.gray)
            }
        }
        }
    }
    
    func dateFormatted() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd LLL yy"
        return dateFormatter.string(from: dateHolder.date)
    }
    
    func moveBack()
    {
        withAnimation
        {
            dateHolder.moveDate(-1, viewContext)
        }
    }
    
    func moveForward()
    {
        withAnimation
        {
            dateHolder.moveDate(1, viewContext)
        }
    }
    
}

struct DateScroller_Previews: PreviewProvider {
    static var previews: some View {
        DateScroller()
    }
}
