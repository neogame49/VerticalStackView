//
//  PhysicianMessageCell.swift
//  MessagingPrototype
//
//  Created by Roman Shcherbii on 1/27/16.
//  Copyright © 2016 Roman Shcherbii. All rights reserved.
//

import UIKit

class PhysicianMessageCell: MessageCell {

    override func layoutSubviews() {
        super.layoutSubviews()

        self.deliveredLabel.sizeToFit()
        var startPoint = CGPoint(x: self.messageViewEdgeOffset, y: self.contentView.frame.maxY - self.dynamicType.VerticalOffset - self.deliveredLabel.frame.size.height)
        self.deliveredLabel.frame.origin = CGPoint(x: startPoint.x + self.deliveredLabelOffsetFromMessageView, y: startPoint.y)

        startPoint.y -= self.dynamicType.SpaceBetweenDeliveredLabelAndLastMessageView
        for messageView in self.messageViews {
            messageView.frame.size.width = self.dynamicType.MaxMessageViewHeight
            startPoint.y -= messageView.frame.height
            startPoint.y -= self.dynamicType.SpaceBetweenMessageViews
        }

        //let deliveredLabelSize = self.deliveredLabel.frame.size
    }
}
