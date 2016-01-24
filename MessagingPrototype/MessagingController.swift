//
//  MessagingController.swift
//  MessagingPrototype
//
//  Created by Roman on 1/23/16.
//  Copyright © 2016 Roman Shcherbii. All rights reserved.
//

import UIKit


class MessagingController: UITableViewController {

    let cellIdentifier = "MessagingCell"
    
    var cellStrings: [[String]] = {
        var stringArray = [
            ["first label"],
            ["second label", "first label"],
            ["thirty label", "second label", "first label"],
            ["thirty label", "second label", "first label", "long text ckvkfjgfjgfjgfjgbv bnbfjgbfhgfhjgb jdffhjfhj djfdjhfh djfhjdfhj djhfjh "]
        ]
        
        for _ in 1...10 {
            stringArray += [
                ["first label"],
                ["second label", "first label"],
                ["thirty label", "second label", "first label"],
                ["thirty label", "second label", "first label", "long text ckvk fjgf jgfjgfjgbv bnbfjgb fhgfhjgb jdffhjfhj djfdjhfh djfhjdfhj djhfjh "]
            ]

        }

        return stringArray
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MessagingCell
        
        let strings = self.cellStrings[indexPath.row]
        
        let labels = strings.map { (str) -> MessagingView in
            let mView = MessagingView()
            //mView.labelEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            mView.label.text = str
            return mView
        }
        
        cell.messagingStask.views = labels
        
        return cell
    }
    
    
    override  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellStrings.count
    }
}
