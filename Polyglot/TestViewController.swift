//
//  TestViewController.swift
//  Polyglot
//
//  Created by Arinjay Sharma on 3/28/17.
//  Copyright © 2017 Arinjay Sharma. All rights reserved.
//

import UIKit
import GameplayKit

class TestViewController: UIViewController {

    @IBOutlet weak var stackViews: UIStackView!
    @IBOutlet weak var prompt: UILabel!
    
    
    var words: [String]!
    var questionCounter = 0
    var showingQuestion = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(nextTapped))
        
        GKRandomSource.sharedRandom().arrayByShufflingObjects(in: words) as! [String]
        title = "TEST"
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    
    func nextTapped(){
        
        showingQuestion = !showingQuestion
        if showingQuestion {
            prepareForNextQuestion()
        }
        else{
            prompt.text = words[questionCounter].components(separatedBy: "::")[0]
            prompt.textColor = UIColor(red: 0, green: 0.7, blue: 0, alpha: 1)
        }
    }
    
    
    func askquestion(){
        
    }
    
    func prepareForNextQuestion(){
        prompt.textColor = UIColor.black
        
        askquestion()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
