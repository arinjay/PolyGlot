//
//  ViewController.swift
//  Polyglot
//
//  Created by Arinjay Sharma on 3/19/17.
//  Copyright © 2017 Arinjay Sharma. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var words = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewWord))
       
        if let defaults = UserDefaults(suiteName: "group.com.Arinjay.Polyglot"){
            
            if let saveWords = defaults.object(forKey: "words") as? [String]{
                words = saveWords
            }
            else{
              saveInitialWords(to: defaults)
            }
        }
    }
    
    func saveInitialWords(to default: UserDefaults){
        words.append("Hi::Hallo")
        words.append("Time::Zeit")
        words.append("Chicken::Hähnchen")
        words.append("Sir::Herr")
        words.append("Brother::Bruder")
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        let word = words[indexPath.row]
        let split = word.components(separatedBy: "::")
        cell.textLabel?.text = split[0]
        
        cell.detailTextLabel?.text = ""

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        words.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        savewords()
    }
    
    func savewords(){
        if let defaults = UserDefaults(suiteName: "group.com.Arinjay.Polyglot")
        {
            defaults.set(words, forKey: "Words")
        }
    }
    
    
    func addNewWord(){
        
        let ac = UIAlertController(title: "Add you word", message: nil, preferredStyle: .alert)
        
        ac.addTextField { (textField) in
            textField.placeholder = "English"
        }
        
        ac.addTextField { (textField) in
            textField.placeholder = "German"
        }
        
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [unowned self,ac]
            (action:UIAlertAction!) in
            
            
//            let firstWord = ac.textFields?.[0].text ??; ""
//            let secondWord = ac.textFields?.[1].text ?? " "
              let firstWord = ac.textFields?[0].text ?? ""
              let socondWord = ac.textFields?[1].text ?? ""
            
            self.insertFlashCard(first: firstWord, second: socondWord)
        }
        
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "hey", style: .cancel))
        
        present(ac, animated: true)
    }
    
    
    func insertFlashCard(first: String, second: String){
        
        //check for empty string
        guard first.characters.count > 0 && second.characters.count > 0  else {return}
        
        //new indexpath will be +1
        let newIndexPath = IndexPath(row: words.count, section:0)
        
        words.append("\(first)::\(second)")
        
        //adding to tableview
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        
        savewords()
    }
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

