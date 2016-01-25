//
//  MessagingCell.swift
//  MessagingPrototype
//
//  Created by Roman on 1/23/16.
//  Copyright © 2016 Roman Shcherbii. All rights reserved.
//

import UIKit

class MessagingCell: UITableViewCell {

    static let verticalOffset: CGFloat = 8.0
    static let avatarHeight: CGFloat = 50

    var messagingViews: [MessagingView] = []

    var messages: [String] = [] {
        willSet {
            self.messagingViews.forEach{ $0.removeFromSuperview() }
        }
        didSet {
            let start = NSDate()

            self.messagingViews = self.messages.map({ (message) -> MessagingView in
                let messagingView = MessagingView()
                messagingView.label.text = message
                messagingView.preferedWidth = 200//self.contentView.frame.width / 2.0
                self.contentView.addSubview(messagingView)
                return messagingView
            })

            /*for (index, message) in self.messages.enumerate() {
                var messageView: MessagingView!

                if index < self.messagingViews.count {
                    messageView = self.messagingViews[index]
                } else {
                    messageView = MessagingView()
                    self.messagingViews.append(messageView)
                }
                messageView.label.text = message
                messageView.preferedWidth = 200//self.contentView.frame.width / 2.0
                self.contentView.addSubview(messageView)
            }*/

            let end = NSDate()
            let interval = end.timeIntervalSinceDate(start)
            let stringInterval = String(format: "%.6f", interval)
            //print(stringInterval)

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
        let start = NSDate()
        var startPoint = CGPoint(x: MessagingCell.avatarHeight + MessagingCell.verticalOffset + MessagingCell.verticalOffset, y:
            self.contentView.frame.size.height - MessagingCell.verticalOffset)
        for messagingView in self.messagingViews.reverse() {
            let size = messagingView.preferedContentSizeForWidth(messagingView.preferedWidth)

            startPoint.y -= size.height
            messagingView.frame = CGRect(origin: startPoint, size: size)

            let end = NSDate()
            let interval = end.timeIntervalSinceDate(start)
            let stringInterval = String(format: "%.6f", interval)
            print(stringInterval)
        }
    }

    static private let messagingViewForCalculation = MessagingView()

    class func heightForMessages(messages: [String]) -> CGFloat {
        var height: CGFloat = verticalOffset + verticalOffset

        for message in messages {
            self.messagingViewForCalculation.label.text = message

            height += self.messagingViewForCalculation.preferedContentSizeForWidth(200).height
        }
        //print("height = \(height)")
        return max(height, self.avatarHeight + verticalOffset + verticalOffset)
    }
}
