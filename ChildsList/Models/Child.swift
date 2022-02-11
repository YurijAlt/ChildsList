//
//  Child.swift
//  ChildsList
//
//  Created by Юрий Альт on 10.02.2022.
//

struct Child {
    
    let name: String
    let age: Int
    
    static func getChilds() -> [Child] {
        let childs = [
            Child(name: "Юра", age: 3),
            Child(name: "Оля", age: 1),
            Child(name: "Саша", age: 2)
        ]
        return childs
    }
    
}


