//
//  ViewController.swift
//  CoreDataContacts
//
//  Created by Niclas Borrmann on 29.11.22.
//

import UIKit

class ContactsViewController: UIViewController {
    
    var courses: [Course]?
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func showAddContactsView() {
        performSegue(withIdentifier: "AddCourseSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(onCourseWasAdded(_ :)), name: NSNotification.Name.init("courseWasAddedNotification"), object: nil)
    }
    
    func fetchCourses(){
        do {
            self.courses = try context.fetch(Course.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Error by trying fetch request")
        }
    }
    
    @objc func onCourseWasAdded(_ notification: NSNotification) {
        self.fetchCourses()
    }
}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath)
        let contact = self.courses![indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = contact.topic
        cell.contentConfiguration = content
        
        return cell
    }
}

