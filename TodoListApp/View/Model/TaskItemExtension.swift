//
//  TaskItemExtension.swift
//  TodoListApp
//
//  Created by apprenant02 on 04/01/2023.
//

import SwiftUI

extension Item
{
    
    func isCompleted() -> Bool
    {
        return timestamp != nil
    }
    
    func isOverDue() -> Bool
    {
        if let due = dueDate
        {
            return !isCompleted() && scheduleTime && due < Date()
        }
        return false
    }
    
    func overDueColor() -> Color
    {
        return  isOverDue() ? .red : .black
    }
    
    func dueDateTimeOnly() -> String
    {
        if let due = dueDate
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            return dateFormatter.string(from: due)
        }
        return ""
    }
    
}
