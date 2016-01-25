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

    var rowHeightCache: [NSIndexPath : CGFloat] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .None
        
        /*self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0*/
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MessagingCell

        return cell
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? MessagingCell {
            let messages = self.cellStrings[indexPath.row]
            cell.messages = messages
        }
    }
    
    override  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellStrings.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if let cachedHeight = self.rowHeightCache[indexPath] {
            return cachedHeight
        }
        let messages = self.cellStrings[indexPath.row]
         let height = MessagingCell.heightForMessages(messages)
        self.rowHeightCache[indexPath] = height
        return height
    }

    /*override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }*/
}
