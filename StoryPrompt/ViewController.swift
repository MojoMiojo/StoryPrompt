//
//  ViewController.swift
//  StoryPrompt
//
//  Created by Mozart Sousa on 15/12/21.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		let storyPrompt = StoryPromptEntry()
		storyPrompt.noun = "Toaster"
		storyPrompt.adjective = "smelly"
		storyPrompt.verb = "burps"
		storyPrompt.number = 10
		print(storyPrompt)
	}


}
