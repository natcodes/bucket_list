//
//  ViewController.swift
//  bucketlist
//
//  Created by Natalie Nuno on 3/13/18.
//  Copyright © 2018 Natalie Nuno. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTVCDelegate {
    
    var items = [BucketListItem]()

    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //var name is irrelevant: this line manages the changes made to objects. can be replaced by context.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchAllItems()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        //format table by indicating number of rows.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // format cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "list_item_cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
    }
    // ====================== SAVE ITEM FUNC W CORE DATA ======================
    
    func itemSaved(by controller: AddViewController, with text: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath {
            let item = items[ip.row]
            item.text = text
        }else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            print(text)
            item.text = text
            items.append(item)
        }
        do {    //DO TRY TO SAVE ITEM
            try managedObjectContext.save()
        }catch{
            print("\(error)")
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonPressed(by controller: AddViewController) {
        //cancel button dismisses the view but via this controller. No view can dismiss itself.
        dismiss(animated: true, completion: nil)
    }
    
    //====================================   FETCH ALL =================================================
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let result = try managedObjectContext.fetch(request) //method throws so we need to try, wrap in do-try.
            items = result as! [BucketListItem]
        } catch {
            print("/(error)")
        }
    }
    
    // =============== CIRCLE TO EDIT SELECTION DYNAMIC CELLS =======
    
   override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //responds to accessory circle being selected. Tell it to do something.
        performSegue(withIdentifier: "AddEditItemSegue", sender: indexPath)
    }
    
    
    
    //  ============ DELETE entry with swipe left =======
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row] //create the managed object var to pass to the delete function.
        print(item)
        managedObjectContext.delete(item)
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        } //must save changes regardless of which CRUD opperation.
        items.remove(at: indexPath.row) //remove the cell after deletion.
        tableView.reloadData() //reload it without the cell and data.
    }
    
    // ====================== HANDSHAKE ================
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // indicates...
        let navController = segue.destination as! UINavigationController
        let addItemViewController = navController.topViewController as! AddViewController
        addItemViewController.delegate = self
        
        if let indexPath = sender as? NSIndexPath {
            let item = items[indexPath.row]
            addItemViewController.item = item.text!
            addItemViewController.indexPath = indexPath
        }
            //this delegate is by name of the var not the file
    }
    
}

