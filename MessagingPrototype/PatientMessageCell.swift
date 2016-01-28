//
//  PatientMessageCell.swift
//  MessagingPrototype
//
//  Created by Roman Shcherbii on 1/27/16.
//

import UIKit

class PatientMessageCell: MessageCell {

    override class func messageView() -> MessageView {
        let messageView = super.messageView()
        messageView.appearanceMode = .RightSide
        return messageView
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.deliveredLabel.sizeToFit()
        var startPoint = CGPoint(x: self.contentView.frame.maxX - self.messageViewEdgeOffset, y: self.contentView.frame.maxY - self.dynamicType.VerticalOffset - self.deliveredLabel.frame.size.height)
        self.deliveredLabel.frame.origin = CGPoint(x: startPoint.x - (self.deliveredLabel.frame.size.width + self.deliveredLabelOffsetFromMessageView), y: startPoint.y)

        startPoint.y -= self.dynamicType.OffsetBetweenDeliveredLabelAndLastMessageView
        for messageView in self.messageViews.reverse() {
            let messageViewSize = messageView.preferredContentSizeForWidth(self.dynamicType.MaxMessageViewWidth)
            startPoint.y -= messageViewSize.height
            messageView.frame = CGRect(origin: CGPoint(x: startPoint.x - messageViewSize.width, y: startPoint.y), size: messageViewSize)

            startPoint.y -= self.dynamicType.OffsetBetweenMessageViews
        }
    }

}
