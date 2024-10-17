//
//  TaskListViewModel.swift
//  SampleMVVM
//
//  Created by Sedat on 15.10.2024.
//

import Foundation

class TaskListViewModel {
    
    var tasks: [Task] = [] {
        didSet {
            saveTasksToUserDefaults()
        }
    }
    
    init() {
        loadTasksFromUserDefaults()
    }
    
    func addTask(title: String) {
        let task = Task(title: title)
        tasks.append(task)
    }
    
    func deleteTask(at index: Int) {
        tasks.remove(at: index)
    }
    
    func toggleTaskCompletion(at index: Int) {
        tasks[index].isCompleted.toggle()
    }
    
    var tasksCount: Int {
        return tasks.count
    }
    
    func task(at index: Int) -> Task {
        return tasks[index]
    }

    private func saveTasksToUserDefaults() {
        let encoder = JSONEncoder()
        if let encodedTasks = try? encoder.encode(tasks) {
            UserDefaults.standard.set(encodedTasks, forKey: "tasks")
        }
    }
    
    private func loadTasksFromUserDefaults() {
        if let savedTasksData = UserDefaults.standard.data(forKey: "tasks") {
            let decoder = JSONDecoder()
            if let savedTasks = try? decoder.decode([Task].self, from: savedTasksData) {
                self.tasks = savedTasks
            }
        }
    }
}
