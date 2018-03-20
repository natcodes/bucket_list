//
//  AddItemTVCDelegate.swift
//  bucketlist
//
//  Created by Natalie Nuno on 3/13/18.
//  Copyright © 2018 Natalie Nuno. All rights reserved.
//

import Foundation

protocol AddItemTVCDelegate: class {
    func itemSaved(by controller: AddViewController, with text: String, at indexPath: NSIndexPath?)
    func cancelButtonPressed(by controller: AddViewController)
}
