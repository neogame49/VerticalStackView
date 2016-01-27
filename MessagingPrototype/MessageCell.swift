//
//  MessageCell.swift
//  MessagingPrototype
//
//  Created by Roman Shcherbii on 1/27/16.
//  Copyright © 2016 Roman Shcherbii. All rights reserved.
//

import UIKit

// base class for else message cell
class MessageCell: UITableViewCell {
    //@IBOutlet var avatarView: UIImageView?
    @IBOutlet var deliveredLabel: UILabel!

    static var MaxMessageViewHeight: CGFloat = 100.0

    static let VerticalOffset: CGFloat = 8.0 // offset from top and bottom
    static let SideLengthForAvatar: CGFloat = 62.0 // length for width and height of the avatarView
    static let SpaceBetweenDeliveredLabelAndLastMessageView: CGFloat = 2.0
    static let SpaceBetweenMessageViews: CGFloat = 4.0
    var deliveredLabelOffsetFromMessageView: CGFloat = 16.0

    var messageViewEdgeOffset: CGFloat {
        if self.traitCollection.userInterfaceIdiom == .Pad { // for ipads
            return 15.0
        } else { // for other
            return 8.0
        }
    }

    class func messageView() -> MessageView {
        return MessageView()
    }

    /// used for calculation purpose
    static let messageViewForCalculation: MessageView = MessageCell.messageView()

    class func heightForMessages(messages: [String]) -> CGFloat {
        var height: CGFloat = self.VerticalOffset + self.VerticalOffset

        // TODO: in TeleMed replace on a real font
        let fontForDeliveredLabel = UIFont.systemFontOfSize(12.0)
        let attributes: [String: AnyObject] = [NSFontAttributeName: fontForDeliveredLabel]
        height += ("somestring" as NSString).sizeWithAttributes(attributes).height + self.SpaceBetweenDeliveredLabelAndLastMessageView

        for message in messages {
            self.messageViewForCalculation.label.text = message
            height += self.messageViewForCalculation.preferredContentSizeForWidth(self.MaxMessageViewHeight).height
        }
        height += CGFloat(messages.count - 1) * self.SpaceBetweenMessageViews
        return height
        //print("height = \(height)")
        //return max(height, self.avatarHeight + verticalOffset + verticalOffset)
    }

    private(set) var messageViews: [MessageView] = []

    var messages: [String] = [] {
        willSet {
            self.messageViews.forEach({$0.removeFromSuperview()})
        }

        didSet {
            self.messageViews = messages.map({ (message) -> MessageView in
                let messageView = self.dynamicType.messageView()
                messageView.label.text = message
                self.addSubview(messageView)
                return messageView
            })
            if let lastMessageView =  self.messageViews.last {
                lastMessageView.showArrow = true
            }
            
            self.setNeedsLayout()
        }
    }


}
