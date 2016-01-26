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
            ["thirty label", "second label", "first label", "long text ckvkfjgfjgfjgfjgbv bnbfjgbfhgfhjgb jdffhjfhj djfdjhfh djfhjdfhj djhfjh ", "fk lfklfkdf gtjuirt itroi bkv kbkb gjfogi gijh high hgohi ghghio higoh hoig oihghogh io hgo gohgo"]
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
        MessagingCell.messagingViewWidth = self.tableView.frame.size.width / 2.0
        //self.tableView.separatorStyle = .None

    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        print("viewWillTransitionToSize")
        MessagingCell.messagingViewWidth = size.width / 2.0

        let visibleCells = self.tableView.visibleCells
        self.tableView.reloadRowsAtIndexPaths(visibleCells.map{ self.tableView.indexPathForCell($0)!}, withRowAnimation: .None)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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

        let messages = self.cellStrings[indexPath.row]
         let height = MessagingCell.heightForMessages(messages)
        return height
    }

}
