//
//  MessagingCell.swift
//  MessagingPrototype
//
//  Created by Roman on 1/23/16.
//  Copyright © 2016 Roman Shcherbii. All rights reserved.
//

import UIKit

class MessagingCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messagingStask: VerticalStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
