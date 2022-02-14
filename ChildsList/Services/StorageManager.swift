//
//  StorageManager.swift
//  ChildsList
//
//  Created by Юрий Альт on 10.02.2022.
//

class DataManager {
    
    static let shared = DataManager()
    
    var addedChilds: [Child] = []
    
    private init() {}
}


