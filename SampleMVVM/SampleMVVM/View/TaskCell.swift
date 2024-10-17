//
//  TaskCell.swift
//  SampleMVVM
//
//  Created by Sedat on 15.10.2024.
//

import UIKit
import SnapKit

class TaskCell: UITableViewCell {
    
    let taskLabel = UILabel()
    let completedIndicatorImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        completedIndicatorImageView.contentMode = .scaleAspectFit
        contentView.addSubview(completedIndicatorImageView)
        completedIndicatorImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        backgroundColor = .clear
        taskLabel.font = UIFont.systemFont(ofSize: 16)
        taskLabel.numberOfLines = 0
        taskLabel.textColor = .black
        contentView.addSubview(taskLabel)
        taskLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(completedIndicatorImageView.snp.left)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with task: Task) {
        taskLabel.text = task.title
        completedIndicatorImageView.image = task.isCompleted ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
    }
}
