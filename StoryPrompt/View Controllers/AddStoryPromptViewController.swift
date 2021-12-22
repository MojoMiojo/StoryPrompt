//
//  ViewController.swift
//  StoryPrompt
//
//  Created by Mozart Sousa on 15/12/21.
//

import UIKit
import PhotosUI

class AddStoryPromptViewController: UIViewController {
	
	let storyPrompt = StoryPromptEntry()
	
	@IBOutlet weak var nounTextField: UITextField!
	@IBOutlet weak var adjectiveTextField: UITextField!
	@IBOutlet weak var verbTextField: UITextField!
	@IBOutlet weak var numberSlider: UISlider!
	@IBOutlet weak var numberLabel: UILabel!
	@IBOutlet weak var storyPromptImageView: UIImageView!
	
	@IBAction func changeNumber(_ sender: UISlider) {
		numberLabel.text = "Number: \(Int(sender.value))"
		storyPrompt.number = Int(sender.value)
	}
	
	@IBAction func changeStoryType(_ sender: UISegmentedControl) {
		
		if let genre = StoryPrompts.Genre(rawValue: sender.selectedSegmentIndex){
			storyPrompt.genre = genre
		}else{
			storyPrompt.genre = .scifi
		}
		print(storyPrompt.genre)
	}//end changeStoryType
	
	@IBAction func generateStoryPrompt(_ sender: Any) {
		updateStoryPrompt()
		
		if storyPrompt.isValid() {
			performSegue(withIdentifier: "StoryPrompt", sender: nil)
			//print(storyPrompt)
		}	else {
			let alert = UIAlertController(title: "Invalid Story Prompt", message: "Please fill out all of the fields", preferredStyle: .alert)
			let action = UIAlertAction(title: "OK", style: .default, handler: {action in})
			
			alert.addAction(action)
			
			present(alert, animated: true)
		}//end else
	}
	
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeImage))
		
		numberSlider.value = 7.5
		
		storyPromptImageView.isUserInteractionEnabled = true
		storyPromptImageView.addGestureRecognizer(gestureRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateStoryPrompt), name: UIResponder.keyboardDidHideNotification, object: nil)
	}//end viewDidLoad
	
	@objc func updateStoryPrompt(){
		storyPrompt.noun = nounTextField.text ?? ""
		storyPrompt.adjective = adjectiveTextField.text ?? ""
		storyPrompt.verb = verbTextField.text ?? ""
		storyPrompt.number = Int(numberSlider.value)
	}//end updateStoryPrompt
	
	@objc func changeImage(){
		var configuration = PHPickerConfiguration()
		
		configuration.filter = .images
		configuration.selectionLimit = 1
		
		let controller = PHPickerViewController(configuration: configuration)
		controller.delegate = self
		present(controller, animated: true)
	}//end changeImage
	
	override func prepare ( for segue: UIStoryboardSegue, sender: Any?){
		if segue.identifier == "StoryPrompt"{
			guard let storyPromptViewController = segue.destination as? StoryPromptViewController else{
				return
			}
			storyPromptViewController.storyPrompt = storyPrompt
            storyPromptViewController.isNewStoryPrompt = true
		}
	}//end prepare`
	
}//end AddStoryPromptViewController

extension AddStoryPromptViewController : UITextFieldDelegate{
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}//end textFieldShouldReturn
}//end AddStoryPromptViewController : UITextFieldDelegate

extension AddStoryPromptViewController : PHPickerViewControllerDelegate{
	func picker(_ picker: PHPickerViewController, didFinishPicking results:[PHPickerResult]){
		if !results.isEmpty{
			let result = results.first!
			let itemProvider = result.itemProvider
			if itemProvider.canLoadObject(ofClass: UIImage.self){
				itemProvider.loadObject(ofClass: UIImage.self){ [weak self] image, error in
					guard let image = image as? UIImage else {
						return
					}
					DispatchQueue.main.async {
						self?.storyPromptImageView.image = image
					}
				}
			}
		}
	}//end picker
}// end AddStoryPromptViewController : PHPickerViewControllerDelegate
