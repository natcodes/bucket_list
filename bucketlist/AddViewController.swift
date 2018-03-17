//
//  AddViewController.swift
//  bucketlist
//
//  Created by Natalie Nuno on 3/13/18.
//  Copyright © 2018 Natalie Nuno. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController {
    weak var delegate: CancleButtonDelegate?
    
    @IBAction func cancelBarButtonPressed(_ sender: Any) {
        delegate?.cancelButtonPressed(by: self)
        print("cancel")
    }
}
