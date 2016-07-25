//
//  ViewController.swift
//  CoreDataTwo
//
//  Created by wealthyjalloh on 25/07/2016.
//  Copyright © 2016 CWJ. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var results: NSArray?
    // properties
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var table: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: UIButton) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate  as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let cell = NSEntityDescription.insertNewObjectForEntityForName("Form", inManagedObjectContext: context)
        cell.setValue(name, forKey: "name")
        cell.setValue(surname, forKey: "surname")
        
        do {
            try context.save()
        } catch {
            
        }
        
        self.loadTable()
        self.table.reloadData()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results!.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Contacts"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        let aux = results![indexPath.row] as! NSManagedObject
        cell.textLabel!.text = aux.valueForKey("name") as? String
        cell.detailTextLabel!.text = aux.valueForKey("surname") as? String
        
        return cell
    }
    
    
    func loadTable() {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "Form")
        request.returnsObjectsAsFaults = false
        results = try? context.executeFetchRequest(request)
        
    }


}

