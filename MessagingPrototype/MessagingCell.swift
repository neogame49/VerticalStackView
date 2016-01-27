//
//  MessagingCell.swift
//  MessagingPrototype
//
//  Created by Roman on 1/23/16.
//  Copyright © 2016 Roman Shcherbii. All rights reserved.
//

import UIKit

class MessagingCell: UITableViewCell {

    static var messagingViewWidth: CGFloat = 100.0
    static let verticalOffset: CGFloat = 8.0
    static let avatarHeight: CGFloat = 50

    var messagingViews: [MessageView] = []

    var messages: [String] = [] {
        willSet {
            self.messagingViews.forEach{ $0.removeFromSuperview() }
        }
        didSet {
            self.messagingViews = self.messages.map({ (message) -> MessageView in
                let messagingView = MessageView()
                messagingView.label.text = message
                messagingView.backgroundColor = UIColor.clearColor()
                messagingView.appearanceMode = .RightSide
                if let lastMessage = self.messages.last where message == lastMessage {
                    messagingView.showArrow = true
                } else {
                    messagingView.showArrow = false
                }
                self.contentView.addSubview(messagingView)
                return messagingView
            })
            
            self.setNeedsLayout()
        }
    }

    @IBOutlet weak var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var startPoint = CGPoint(x: MessagingCell.avatarHeight + MessagingCell.verticalOffset + MessagingCell.verticalOffset, y:
            self.contentView.frame.size.height - MessagingCell.verticalOffset)
        /*var startPoint = CGPoint(x: self.avatarImageView.frame.maxX + MessagingCell.verticalOffset, y:
            self.avatarImageView.frame.maxY)*/

        for messagingView in self.messagingViews.reverse() {
            let size = messagingView.preferredContentSizeForWidth(MessagingCell.messagingViewWidth)

            startPoint.y -= size.height
            messagingView.frame = CGRect(origin: startPoint, size: size)
        }
    }

    static private let messagingViewForCalculation = MessageView()

    class func heightForMessages(messages: [String]) -> CGFloat {
        var height: CGFloat = verticalOffset + verticalOffset

        for message in messages {
            self.messagingViewForCalculation.label.text = message

            height += self.messagingViewForCalculation.preferredContentSizeForWidth(MessagingCell.messagingViewWidth).height
        }
        //print("height = \(height)")
        return max(height, self.avatarHeight + verticalOffset + verticalOffset)
    }
}
