//
//  ViewController.swift
//  ChildsList
//
//  Created by Юрий Альт on 10.02.2022.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: Private Properties
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
        button.setTitle("    ╋ Добавить ребёнка    ", for: .normal)
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
    
    //MARK: Override Methods
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.layer.cornerRadius = addButton.frame.height / 2
        clearButton.layer.cornerRadius = clearButton.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setup(subviews: nameLabel, nameTextField, ageLabel, ageTextField, personDataLabel, childsMaximumLabel, tableView, addButton, clearButton)
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
    }

    //MARK: Private Methods
    private func setup(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupConstraints() {
        //PERSONAL DATA LABEL
        personDataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personDataLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            personDataLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
        //NAME LABEL
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: personDataLabel.bottomAnchor, constant: 30),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
        //NAME TEXT FIELD
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            nameTextField.heightAnchor.constraint(equalToConstant: 20)
        ])
        //AGE LABEL
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
            ageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ])
        //AGE TEXT FIELD
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ageTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10),
            ageTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            ageTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            ageTextField.heightAnchor.constraint(equalToConstant: 20)
        ])
        //CHILDS MAXIMUM LABEL
        childsMaximumLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childsMaximumLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 40),
            childsMaximumLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])
        //ADD BUTTON
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            //addButton.leftAnchor.constraint(equalTo: childsMaximumLabel.rightAnchor, constant: 25),
            addButton.centerYAnchor.constraint(equalTo: childsMaximumLabel.centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 54)
        ])
        //TABLE VIEW
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: childsMaximumLabel.bottomAnchor, constant: 30),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -30)
        ])
       //CLEAR BUTTON
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            clearButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80),
            clearButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80),
            clearButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    @objc private func addNewChild() {
        childs.append(Child(name: "Пора спать, на часах уже", age: 5))
        print("Данные добавлены")
    }
    
    private func hideTheAddButton() {
        if childs.count < 2 {
            clearButton.isEnabled = false
        }
    }
    
    @objc private func showActionSheetViewController() {
        let actionSheet = UIAlertController(title: nil, message: "Выбирите действие", preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: "Сбросить данные", style: .destructive) { _ in
            print("Данные стерты")
            self.tableView.reloadData()
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
        childs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaincTableViewCell.identifier) as! MaincTableViewCell
        let child = childs[indexPath.row]
        cell.setupIUFromModel(child: child)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
