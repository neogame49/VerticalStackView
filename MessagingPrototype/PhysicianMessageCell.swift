//
//  PhysicianMessageCell.swift
//  MessagingPrototype
//
//  Created by Roman Shcherbii on 1/27/16.
//

import UIKit

class PhysicianMessageCell: MessageCell {
    static var ShouldShowAvatar: Bool = false

    static let SideLengthForAvatar: CGFloat = 62.0 // length for width and height of the avatarView
    static let AvatarEdgeOffset: CGFloat = 15.0
    static let SpaceBetweenAvatarAndMessageView: CGFloat = 5.0

    var avatarView: UIImageView?

    override func layoutSubviews() {
        super.layoutSubviews()

        self.deliveredLabel.sizeToFit()
        let startOffset = self.dynamicType.ShouldShowAvatar ? self.contentView.frame.minX + self.dynamicType.AvatarEdgeOffset + self.dynamicType.SideLengthForAvatar +
        self.dynamicType.SpaceBetweenAvatarAndMessageView : self.contentView.frame.minX + self.messageViewEdgeOffset
        var startPoint = CGPoint(x: startOffset, y: self.contentView.frame.maxY - self.dynamicType.VerticalOffset - self.deliveredLabel.frame.size.height)

        self.deliveredLabel.frame.origin = CGPoint(x: startPoint.x + self.deliveredLabelOffsetFromMessageView, y: startPoint.y)
        startPoint.y -= self.dynamicType.OffsetBetweenDeliveredLabelAndLastMessageView

        if let avatarView = self.avatarView where self.dynamicType.ShouldShowAvatar {
            avatarView.frame = CGRect(x: self.contentView.frame.minX + self.dynamicType.AvatarEdgeOffset , y: startPoint.y - self.dynamicType.SideLengthForAvatar,
                width: self.dynamicType.SideLengthForAvatar, height: self.dynamicType.SideLengthForAvatar)
        }

        for messageView in self.messageViews.reverse() {
            let messageViewSize = messageView.preferredContentSizeForWidth(self.dynamicType.MaxMessageViewWidth)
            startPoint.y -= messageViewSize.height
            messageView.frame = CGRect(origin: startPoint, size: messageViewSize)

            startPoint.y -= self.dynamicType.OffsetBetweenMessageViews
        }
    }

    override func setup() {
        super.setup()
        if self.dynamicType.ShouldShowAvatar {
            self.avatarView = UIImageView()
            self.avatarView?.backgroundColor = UIColor.greenColor()
            self.contentView.addSubview(self.avatarView!)
        }
    }

    override class func HeightForMessages(messages: [String], deliveredText: String = "Delivered") -> CGFloat {
        let calculatedHeight = super.HeightForMessages(messages, deliveredText: deliveredText)
        if self.ShouldShowAvatar {
            let minHeight = self.VerticalOffset + self.VerticalOffset + self.HeightForDeliveredText(deliveredText) +
                self.OffsetBetweenDeliveredLabelAndLastMessageView + self.SideLengthForAvatar
            return max(calculatedHeight, minHeight)
        }
        return calculatedHeight
    }

}
