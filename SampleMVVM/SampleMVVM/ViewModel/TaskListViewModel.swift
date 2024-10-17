//
//  TaskListViewModel.swift
//  SampleMVVM
//
//  Created by Sedat on 15.10.2024.
//

import Foundation

class TaskListViewModel {
    private var tasks: [Task] = []
    
    var tasksCount: Int {
        return tasks.count
    }
    
    func task(at index: Int) -> Task {
        return tasks[index]
    }
    
    func addTask(title: String) {
        let newTask = Task(title: title, isCompleted: false)
        tasks.append(newTask)
    }
    
    func toggleTaskCompletion(at index: Int) {
        tasks[index].isCompleted.toggle()
    }
    
    func deleteTask(at index: Int) {
        tasks.remove(at: index)
    }
}
