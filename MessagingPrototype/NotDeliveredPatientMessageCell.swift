//
//  NotDeliveredPatientMessageCell.swift
//  MessagingPrototype
//
//  Created by Roman Shcherbii on 1/28/16.
//

import UIKit

class NotDeliveredPatientMessageCell: PatientMessageCell {
    static let OffsetBetweenTryAgainButtonAndDeliveredLabel: CGFloat = 4

    var tryAgainAction: ((NotDeliveredPatientMessageCell) -> Void)?

    let tryAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("Try again", forState: .Normal)
        button.titleLabel?.font = MessageCell.AuxiliaryElementsFont
        button.setTitleColor(UIColor.redColor(), forState: .Normal)

        return button
    }()

    override func setup() {
        super.setup()
        self.contentView.addSubview(self.tryAgainButton)
        self.tryAgainButton.addTarget(self, action: "tryAgainAction:", forControlEvents: .TouchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.tryAgainButton.sizeToFit()

        let tryAgainButtonOrigin = CGPoint(x: self.deliveredLabel.frame.maxX - self.tryAgainButton.frame.size.width, y: self.deliveredLabel.frame.origin.y)
        self.tryAgainButton.frame.origin = tryAgainButtonOrigin
        self.tryAgainButton.center.y = self.deliveredLabel.center.y
        self.deliveredLabel.frame.origin.x -= self.tryAgainButton.frame.size.width + self.dynamicType.OffsetBetweenTryAgainButtonAndDeliveredLabel
    }

    func tryAgainAction(sender: UIButton) {
        self.tryAgainAction?(self)
    }

}
