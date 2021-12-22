//
//  StoryPromptTableViewController.swift
//  StoryPrompt
//
//  Created by Mozart Sousa on 20/12/21.
//

import UIKit

class StoryPromptTableViewController: UITableViewController {
	
	var storyPrompts = [StoryPromptEntry]()
	
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
        NotificationCenter.default.addObserver(self, selector: #selector(updateStoryPromptList(notification:)), name: .StoryPromptSaved, object: nil)
		
	}//end viewDidLoad
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		storyPrompts.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "StoryPromptCell", for: indexPath)
		
		cell.textLabel?.text =  "Prompt \(indexPath.row + 1)"
		cell.imageView?.image = storyPrompts[indexPath.row].image
		
		return cell
	}//end tableView
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let storyPrompt = storyPrompts[indexPath.row]
		performSegue(withIdentifier: "ShowStoryPrompt", sender: storyPrompt)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ShowStoryPrompt" {
			guard let storyPromptViewController = segue.destination as? StoryPromptViewController,
						let storyPrompt = sender as? StoryPromptEntry else {
							return
						}
			storyPromptViewController.storyPrompt = storyPrompt
		}//end if
	}//end prepare
	
	@IBAction func saveStoryPrompt(unwindSegue: UIStoryboardSegue){
        //		guard let storyPromptViewController = unwindSegue.source as? StoryPromptViewController,
        //					let storyPrompt = storyPromptViewController.storyPrompt else {
        //						return
        //					}
        //		storyPrompts.append(storyPrompt)
        //		tableView.reloadData()
	}//end saveStoryPrompt
	
	@IBAction func cancelStoryPrompt(unwindSegue: UIStoryboardSegue){
		
	}
	
    @objc func updateStoryPromptList(notification: Notification){
        guard let storyPrompt = notification.object as? StoryPromptEntry else {
            return
        }
        storyPrompts.append(storyPrompt)
        tableView.reloadData()
    }// updateStoryPromptList
    
}// StoryPromptTableViewController
