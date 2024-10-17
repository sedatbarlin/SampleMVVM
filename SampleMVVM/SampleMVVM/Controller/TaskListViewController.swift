//
//  TaskListViewController.swift
//  SampleMVVM
//
//  Created by Sedat on 15.10.2024.
//

import UIKit
import SnapKit

class TaskListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let addTaskButton = UIButton()
    private let viewModel = TaskListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        title = "To-Do List"
        
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(addTaskButton.snp.top).offset(-16)
        }
        
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
    }
    
    @objc private func addTask() {
        let alertController = UIAlertController(title: "New Task", message: "Enter task title", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Task title"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let taskTitle = alertController.textFields?.first?.text, !taskTitle.isEmpty {
                self.viewModel.addTask(title: taskTitle)
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        let task = viewModel.task(at: indexPath.row)
        cell.configure(with: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.toggleTaskCompletion(at: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
