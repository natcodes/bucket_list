//
//  AddViewController.swift
//  bucketlist
//
//  Created by Natalie Nuno on 3/13/18.
//  Copyright © 2018 Natalie Nuno. All rights reserved.
//

import UIKit

class AddViewController: UITableViewController {
    var item: String?
    var indexPath: NSIndexPath?
    
    weak var delegate: AddItemTVCDelegate?
    
    @IBOutlet weak var itemTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if let text = itemTextField.text {
            delegate?.itemSaved(by: self, with: text, at: indexPath)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTextField.text = item
        //        print("hello bucket")
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
