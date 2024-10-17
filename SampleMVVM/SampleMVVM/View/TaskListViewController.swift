//
//  TaskListViewController.swift
//  SampleMVVM
//
//  Created by Sedat on 15.10.2024.
//

import UIKit
import SnapKit

class TaskListViewController: UIViewController {
    
    private let taskTableView = TaskTableView()
    private let addTaskButton = UIButton()
    private let viewModel = TaskListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCallbacks()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "To-Do List"
        
        addTaskButton.setTitle("Add Task", for: .normal)
        addTaskButton.setTitleColor(.white, for: .normal)
        addTaskButton.backgroundColor = .systemBlue
        addTaskButton.layer.cornerRadius = 10
        addTaskButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        view.addSubview(addTaskButton)
        addTaskButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(50)
        }
        
        view.addSubview(taskTableView)
        taskTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(addTaskButton.snp.top).offset(-16)
        }
    }
    
    private func setupCallbacks() {
        taskTableView.onTaskSelected = { [weak self] index in
            self?.viewModel.toggleTaskCompletion(at: index)
            self?.taskTableView.updateTasks(self?.viewModel.tasks ?? [])
        }
        
        taskTableView.onTaskDeleted = { [weak self] index in
            self?.viewModel.deleteTask(at: index)
            self?.taskTableView.updateTasks(self?.viewModel.tasks ?? [])
        }
        
        taskTableView.updateTasks(viewModel.tasks)
    }
    
    @objc private func addTask() {
        let alertController = UIAlertController(title: "New Task", message: "Enter task title", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Task title"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let taskTitle = alertController.textFields?.first?.text, !taskTitle.isEmpty {
                self?.viewModel.addTask(title: taskTitle)
                self?.taskTableView.updateTasks(self?.viewModel.tasks ?? [])
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
