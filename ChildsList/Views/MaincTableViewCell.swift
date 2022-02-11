//
//  MaincTableViewCell.swift
//  ChildsList
//
//  Created by Юрий Альт on 10.02.2022.
//

import UIKit

class MaincTableViewCell: UITableViewCell {
    
    static let identifier = "MainTableViewCell"
    

    var child: Child!
    
    
    private lazy var firstView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.textColor = .lightGray
        return label
    }()
    private lazy var enteredNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя из модели"
        return label
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Возраст"
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var enteredAgeLabel: UILabel = {
        let label = UILabel()
        label.text = "Возраст из модели"
        return label
    }()
    
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.6215080619, blue: 0.9352857471, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(deleteChildFromList), for: .touchUpInside)
        return button
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup(subviews: nameLabel, enteredNameLabel, ageLabel, enteredAgeLabel, deleteButton, firstView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupIUFromModel(child: Child) {
        enteredNameLabel.text = child.name
        enteredAgeLabel.text = String(child.age)
    }
    
    
    private func setup(subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
        }
    }
    
    
    @objc private func deleteChildFromList() {
        
        
        
    }
    
    private func setupConstraints() {
        //NAME LABEL
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ])
        //ENTERED NAME LABEL
        enteredNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enteredNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            enteredNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ])
        
        
        //UIVIEW
        
        firstView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(equalTo: enteredNameLabel.bottomAnchor, constant: 20),
            firstView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            firstView.rightAnchor.constraint(equalTo: deleteButton.rightAnchor, constant: 30)
        ])
        
        //AGE LABEL
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ageLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40)
        ])
        //ENTERED AGE LABEL
        enteredAgeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enteredAgeLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10),
            enteredAgeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ])
        
        
        
        
        //DELETE BUTTON
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            deleteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -100)
        ])
    }
    
    
    
}

