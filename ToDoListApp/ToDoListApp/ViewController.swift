//
//  ViewController.swift
//  ToDoListApp
//
//  Created by 陈文娟 on 2016/11/1.
//  Copyright © 2016年 Heinqi. All rights reserved.
//

import UIKit
import ToDoListKit

class ViewController: UIViewController {

    @IBOutlet weak var showLB: UILabel!
    var textView:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loaddata()
        textView = UITextField()
        
    }

    @IBAction func showEditAlert(_ sender: AnyObject) {
        let alert = UIAlertController(title: "添加事件", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (textView:UITextField) in
            textView.placeholder = "写点啥吧"
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        let okaction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (alertaction :UIAlertAction) in
            
            let textfield = alert.textFields?.first;
            
            TaskService.addItem(title: (textfield?.text!)!)
            self.loaddata()

        }
        alert.addAction(cancelAction)
        alert.addAction(okaction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func loaddata()
    {
        let items = TaskService.getItems()
        self.showLB.text = String("刚刚添加的数据为\(items[items.count-1])")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

