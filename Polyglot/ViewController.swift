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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(StartTest))
        
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startTest))
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "End Test", style: .plain, target: nil, action: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewWord))
        
        let titleAttributes = [NSFontAttributeName: UIFont(name: "AmericanTypewriter", size: 22)!]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "POLYGLOT"
        
        if let defaults = UserDefaults(suiteName: "group.com.NamasteApps.Polyglot") {
            
            if let savedWords = defaults.object(forKey: "Words") as? [String] {
                words = savedWords
                
            } else {
                saveInitialWords(to: defaults)
            }
        }
    }
    
    func saveInitialWords(to defaults: UserDefaults){
        words.append("Hi::Hallo")
        words.append("Time::Zeit")
        words.append("Chicken::Hähnchen")
        words.append("Sir::Herr")
        words.append("Brother::Bruder")
        
        defaults.set(words, forKey: "Words") //this line was missing so i added it
        
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
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            if cell.detailTextLabel?.text == "" {
                let word = words[indexPath.row]
                let split = word.components(separatedBy: "::")
                
                cell.detailTextLabel?.text = split[1]
                
            } else {
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
    
    func StartTest(){
    
        guard let vc = storyboard?.instantiateInitialViewController(withIdentifier:"Test") as?
            TestViewController else{return}
        
        vc.words = words
        navigationController?.pushViewController(vc, animated: true)
    
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

