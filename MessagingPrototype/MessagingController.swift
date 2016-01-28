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
    let physicianMessageCellIdentifier = "PhysicianMessageCell"
    let patientMessageCellIdentifier = "PatientMessageCell"
    let notDeliveredPatientMessageCellIdentifier = "NotDeliveredPatientMessageCell"
    
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
        MessageCell.MaxMessageViewWidth = self.tableView.frame.size.width / 2.0
        self.tableView.separatorStyle = .None

        PhysicianMessageCell.ShouldShowAvatar = self.traitCollection.userInterfaceIdiom == .Pad
        self.tableView.registerClass(PhysicianMessageCell.self, forCellReuseIdentifier: self.physicianMessageCellIdentifier)
        self.tableView.registerClass(PatientMessageCell.self, forCellReuseIdentifier: self.patientMessageCellIdentifier)
        self.tableView.registerClass(NotDeliveredPatientMessageCell.self, forCellReuseIdentifier: self.notDeliveredPatientMessageCellIdentifier)


    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        print("viewWillTransitionToSize")
        MessageCell.MaxMessageViewWidth = size.width / 2.0

        let visibleCells = self.tableView.visibleCells
        self.tableView.reloadRowsAtIndexPaths(visibleCells.map{ self.tableView.indexPathForCell($0)!}, withRowAnimation: .None)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row % 5 == 0 {
            return self.tableView.dequeueReusableCellWithIdentifier(notDeliveredPatientMessageCellIdentifier, forIndexPath: indexPath)
        }

        if indexPath.row % 2 == 0 {
            return self.tableView.dequeueReusableCellWithIdentifier(physicianMessageCellIdentifier, forIndexPath: indexPath)
        } else {
            return self.tableView.dequeueReusableCellWithIdentifier(patientMessageCellIdentifier, forIndexPath: indexPath)
        }

    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? MessageCell {
            let messages = self.cellStrings[indexPath.row]
            cell.deliveredLabel.text = "9:40 AM"
            cell.messages = messages
        }
    }
    
    override  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellStrings.count
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        let messages = self.cellStrings[indexPath.row]
        if indexPath.row % 2 == 0 {
            return PhysicianMessageCell.HeightForMessages(messages)
        } else {
            return PatientMessageCell.HeightForMessages(messages)
        }

    }

}
