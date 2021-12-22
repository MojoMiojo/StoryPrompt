//
//  StoryPromptViewController.swift
//  StoryPrompt
//
//  Created by Mozart Sousa on 17/12/21.
//

import UIKit

class StoryPromptViewController: UIViewController {
    
    @IBOutlet weak var storyPromptTextView: UITextView!
    
    var storyPrompt: StoryPromptEntry?
    var isNewStoryPrompt = false
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        storyPromptTextView.text = storyPrompt?.description
        
        if isNewStoryPrompt {
            let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveStoryPrompt))
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelStoryPrompt))
            
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.leftBarButtonItem = cancelButton
        }//end if
        
    }//end viewDidLoad
    
    //	override func viewWillAppear(_ animated: Bool) {
    //		navigationController?.setNavigationBarHidden(true, animated: animated)
    //	}//end viewWillAppear
    //
    //	override func viewWillDisappear(_ animated: Bool) {
    //		navigationController?.setNavigationBarHidden(false, animated: animated)
    //	}
    
    @objc func saveStoryPrompt( ) {
        NotificationCenter.default.post(name: .StoryPromptSaved, object: storyPrompt)
        performSegue(withIdentifier: "SaveStoryPrompt", sender: nil)
    }
    
    @objc func cancelStoryPrompt( ) {
        performSegue(withIdentifier: "CancelStoryPrompt", sender: nil)
    }
    
}// end StoryPromptViewcontroller

extension Notification.Name{
    static let StoryPromptSaved = Notification.Name("StoryPromptSave")
}
