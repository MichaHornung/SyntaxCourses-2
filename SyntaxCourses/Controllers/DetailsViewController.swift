//
//  ContactDetailViewController.swift
//  CoreDataContacts
//
//  Created by Niclas Borrmann on 29.11.22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var moduleField: UITextField!
    @IBOutlet weak var topicField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func cancelView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveContact(_ sender: UIBarButtonItem) {
        let newCourse = Course(context: self.context)
        newCourse.module = moduleField.text
        newCourse.topic = topicField.text
        do {
            try self.context.save()
        } catch {
            print("Error; context saving")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name.init("courseWasAddedNotification"), object: nil)
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moduleField.delegate = self
        topicField.delegate = self
    }
}

extension DetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}
