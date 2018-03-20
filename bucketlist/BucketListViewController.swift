//
//  ViewController.swift
//  bucketlist
//
//  Created by Natalie Nuno on 3/13/18.
//  Copyright © 2018 Natalie Nuno. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, AddItemTVCDelegate {
    
    var items = ["Go to Brazil, Greece and Peru", "ride a motorcicle", "surf in Costa Rica"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //what happens when the view loads.
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
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func itemSaved(by controller: AddViewController, with text: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath {
            items[ip.row] = text
        }else {
            items.append(text)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonPressed(by controller: AddViewController) { //cancel button dismisses the view but via this controller. No view can dismiss itself.
        dismiss(animated: true, completion: nil)
    }
    
   override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //responds to accessory circle being selected. tell it to do something...
        performSegue(withIdentifier: "AddEditItemSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // indicates...
        let navController = segue.destination as! UINavigationController
        let addItemViewController = navController.topViewController as! AddViewController
        addItemViewController.delegate = self
        
        
        if let indexPath = sender as? NSIndexPath {
            let item = items[indexPath.row]
            addItemViewController.item = item
            addItemViewController.indexPath = indexPath
        }
            //this delegate is by name of the var not the file
    }
    
}

