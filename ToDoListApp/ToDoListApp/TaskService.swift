//
//  TaskService.swift
//  ToDoListApp
//
//  Created by 陈文娟 on 2016/11/1.
//  Copyright © 2016年 Heinqi. All rights reserved.
//

import Foundation
let taskServiceDataKey = "TaskServiceData"
public struct TaskService {
    public static let ToDoListGroupName = "group.heinqi.com.ExtenstionApp"
    
    public static func addItem(title:String)
    {
        let userDefault = UserDefaults(suiteName: TaskService.ToDoListGroupName);
        var items = self.getItems();
        items.append(title);
        userDefault?.set(items, forKey: taskServiceDataKey);
        userDefault?.synchronize()
        
    }
    
    public static func delItem(title:String)
    {
        let items = getItems()
        let newitem = items.filter{(item) -> Bool in
            item != title
        }
        let userDefault = UserDefaults(suiteName: TaskService.ToDoListGroupName);

        userDefault?.set(newitem, forKey: taskServiceDataKey);
        userDefault?.synchronize()
    }
    
    public static func getItems()-> [String]
    {
        let userDefault = UserDefaults(suiteName: TaskService.ToDoListGroupName);
        var tasks = [String]();
        if let array = userDefault?.stringArray(forKey: taskServiceDataKey)
        {
            tasks = array
        };
        return tasks;
        
    }
}
