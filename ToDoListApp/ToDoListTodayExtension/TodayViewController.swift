//
//  TodayViewController.swift
//  ToDoListTodayExtension
//
//  Created by 陈文娟 on 2016/11/1.
//  Copyright © 2016年 Heinqi. All rights reserved.
//

import UIKit
import NotificationCenter
import ToDoListKit

private let TodayViewControllerMaxCellCount = 3
private let TodayViewControllerCellHeight:CGFloat = 44.0
private let TodayViewControllerTableViewCellKey = "TodayViewControllerTableViewCell"

class TodayViewController: UIViewController, NCWidgetProviding,UITableViewDataSource,UITableViewDelegate {
    private var data:[String]!
    @IBOutlet weak var tableH: NSLayoutConstraint!
    
    @IBOutlet weak var mytableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mytableview.rowHeight = TodayViewControllerCellHeight
        self.loaddata()
        
        // Do any additional setup after loading the view from its nib.
        
    }
    private func loaddata()
    {
        self.data = [String]()
        let items=TaskService.getItems()
        for i in 0..<items.count
        {
            if  i>=3 {
                break;
            }
            self.data.append(items[i]);
        
        
        }
        self.layoutUI()
        self.mytableview.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        self.loaddata()
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    private func layoutUI()
    {
        if self.data.count>0 {
            self.preferredContentSize.height = CGFloat(self.data.count+1)*TodayViewControllerCellHeight
        }
        else{
            self.preferredContentSize.height = 50;
        }
        self.tableH.constant = self.preferredContentSize.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: TodayViewControllerTableViewCellKey)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: TodayViewControllerTableViewCellKey)
            cell.textLabel?.textColor = UIColor.white
            cell.detailTextLabel?.textColor = UIColor.white
        }
        let item = self.data[indexPath.row]
        
        cell.imageView?.image = UIImage(named: "calendar")
        cell.textLabel?.text = "Date & Time"
        cell.detailTextLabel?.text = item
        return cell
    }
   
    @IBAction func addAction(_ sender: AnyObject) {
        let url = NSURL(string: "todolist://add")
        self.extensionContext?.open(url! as URL, completionHandler: nil)
    }
}
