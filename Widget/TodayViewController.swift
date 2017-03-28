//
//  TodayViewController.swift
//  Widget
//
//  Created by Arinjay Sharma on 3/24/17.
//  Copyright © 2017 Arinjay Sharma. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate,UITableViewDataSource {
        
    @IBOutlet weak var tableView: UITableView!
    
    var words = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let defaults = UserDefaults(suiteName: "group.com.Arinjay.Polyglot"){
            
            if let saveWords = defaults.object(forKey: "words") as? [String]{
                words = saveWords
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        let word = words[indexPath.row]
        let split = word.components(separatedBy: "::")
        cell.textLabel?.text = split[0]
        
        cell.detailTextLabel?.text = ""
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.detailTextLabel?.text == ""{
                let word = words[indexPath.row]
                let split = word.components(separatedBy: "::")
                cell.detailTextLabel?.text = split[1]
            }else{
                cell.detailTextLabel?.text = ""
            }
        }
    }

    
    
    
    
    
    
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
