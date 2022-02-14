//
//  ViewController.swift
//  ChildsList
//
//  Created by Юрий Альт on 10.02.2022.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Private Properties
    private var childs = Child.getChilds()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.textColor = .lightGray
        return label
    }()
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Возраст"
        label.textColor = .lightGray
        return label
    }()
    private lazy var ageTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    private lazy var personDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Персональные данные"
        label.textColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        return label
    }()
    private lazy var childsMaximumLabel: UILabel = {
        let label = UILabel()
        label.text = "Дети (макс. 5)"
        label.textColor = #colorLiteral(red: 0.149019599, green: 0.149019599, blue: 0.149019599, alpha: 1)
        return label
    }()
    private lazy var firstView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.9686275125, green: 0.9686275125, blue: 0.9686275125, alpha: 1)
        return view
    }()
    private lazy var secondView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 0.9686275125, green: 0.9686275125, blue: 0.9686275125, alpha: 1)
        return view
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MaincTableViewCell.self, forCellReuseIdentifier: MaincTableViewCell.identifier)
        tableView.rowHeight = 170
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return tableView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("      ╋ Добавить ребёнка      ", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.6215080619, blue: 0.9352857471, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 4
        button.layer.borderColor = #colorLiteral(red: 0, green: 0.6215080619, blue: 0.9352857471, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = button.frame.width / 2
        button.addTarget(self, action: #selector(addNewChild), for: .touchUpInside)
        return button
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.7988835573, green: 0.3092431426, blue: 0.3312832117, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 4
        button.layer.borderColor = #colorLiteral(red: 0.7988835573, green: 0.3092431426, blue: 0.3312832117, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = button.frame.width / 2
        button.addTarget(self, action: #selector(showActionSheetViewController), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Override Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.layer.cornerRadius = addButton.frame.height / 2
        clearButton.layer.cornerRadius = clearButton.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setup(subviews: personDataLabel, firstView, secondView, childsMaximumLabel, tableView, addButton, clearButton)
        firstView.addSubview(nameLabel)
        firstView.addSubview(nameTextField)
        secondView.addSubview(ageLabel)
        secondView.addSubview(ageTextField)
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        hideClearButton()
    }

    //MARK: - Private Methods
    private func setup(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        //MARK: Personal Data Label
        personDataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personDataLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            personDataLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
        
        //MARK: First UIView
        firstView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(equalTo: personDataLabel.bottomAnchor, constant: 10),
            firstView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            firstView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            firstView.heightAnchor.constraint(equalToConstant: 70)
        ])
        //MARK: Name Label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 16)
        ])
        //MARK: Name TextField
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameTextField.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 16),
            nameTextField.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -30),
        ])
        //MARK: Second UIView
        secondView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 10),
            secondView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            secondView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            secondView.heightAnchor.constraint(equalToConstant: 70)
        ])
        //MARK: Age Label
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ageLabel.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 10),
            ageLabel.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 16)
        ])
        //MARK: Age TextField
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ageTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10),
            ageTextField.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 16),
            ageTextField.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -30),
            ageTextField.heightAnchor.constraint(equalToConstant: 20)
        ])
        //MARK: Childs Maximum Label
        childsMaximumLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childsMaximumLabel.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 40),
            childsMaximumLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
        //MARK: Add Button
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            addButton.leftAnchor.constraint(equalTo: childsMaximumLabel.rightAnchor, constant: 20),
            addButton.centerYAnchor.constraint(equalTo: childsMaximumLabel.centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 54)
        ])
        //MARK: TableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: childsMaximumLabel.bottomAnchor, constant: 30),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -30)
        ])
       //MARK: Clear Button
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            clearButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            clearButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            clearButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    private func hideClearButton() {
        if DataManager.shared.addedChilds.isEmpty {
            clearButton.isHidden = true
        } else {
            clearButton.isHidden = false
        }
    }
    
    private func hideAddButton() {
        if DataManager.shared.addedChilds.count >= 5 {
            addButton.isHidden = true
        } else {
            addButton.isHidden = false
        }
    }
    
    
    
    @objc private func addNewChild() {
        print("Данные добавлены")
        let child = Child(name: "Юра", age: 4)
        DataManager.shared.addedChilds.append(child)
        tableView.reloadData()
        hideClearButton()
        hideAddButton()
    }
    
    @objc private func showActionSheetViewController() {
        let actionSheet = UIAlertController(title: nil, message: "Выбирите действие", preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: "Сбросить данные", style: .destructive) { _ in
            DataManager.shared.addedChilds.removeAll()
            self.tableView.reloadData()
            self.hideClearButton()
            self.hideAddButton()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
        }
        actionSheet.addAction(clearAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
}

//MARK: - TableView Delegate and DataSourse
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataManager.shared.addedChilds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaincTableViewCell.identifier) as! MaincTableViewCell
        let child = DataManager.shared.addedChilds[indexPath.row]
        cell.setupIUFromModel(child: child)
        return cell
    }

}
