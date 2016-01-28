//
//  MessageCell.swift
//  MessagingPrototype
//
//  Created by Roman Shcherbii on 1/27/16.
//

import UIKit

// base class for else message cell
class MessageCell: UITableViewCell {
    // MARK: - Layout constants
    static var MaxMessageViewWidth: CGFloat = 100.0

    static let VerticalOffset: CGFloat = 8.0 // offset from top and bottom
    static let OffsetBetweenDeliveredLabelAndLastMessageView: CGFloat = 2.0
    static let OffsetBetweenMessageViews: CGFloat = 4.0

    static var MessageFont = UIFont.systemFontOfSize(16.0) {
        didSet {
            self.messageViewForCalculation = self.messageView()
        }
    }
    static var AuxiliaryElementsFont = UIFont.systemFontOfSize(12.0) // font for delivered label and try again button
    var deliveredLabelOffsetFromMessageView: CGFloat = 16.0
    var messageViewEdgeOffset: CGFloat {
        if self.traitCollection.userInterfaceIdiom == .Pad { // for ipads
            return 16.0
        } else { // for other
            return 8.0
        }
    }

    // MARK: - Height calculation part

    // used for calculation purpose
    private static var messageViewForCalculation: MessageView = MessageCell.messageView()

    class func HeightForMessages(messages: [String], deliveredText: String = "Delivered") -> CGFloat {
        var height: CGFloat = self.VerticalOffset + self.VerticalOffset
        height += self.HeightForDeliveredText(deliveredText) + self.OffsetBetweenDeliveredLabelAndLastMessageView
        for message in messages {
            self.messageViewForCalculation.label.text = message
            height += self.messageViewForCalculation.preferredContentSizeForWidth(self.MaxMessageViewWidth).height
        }
        height += CGFloat(messages.count - 1) * self.OffsetBetweenMessageViews
        return height
    }

    class func HeightForDeliveredText(deliveredText: String) -> CGFloat {
        let attributes: [String: AnyObject] = [NSFontAttributeName: self.AuxiliaryElementsFont]
        return (deliveredText as NSString).sizeWithAttributes(attributes).height
    }

    // MARK: -
    let deliveredLabel: UILabel = {
        let label = UILabel()
        label.font = MessageCell.AuxiliaryElementsFont
        label.textColor = UIColor.lightGrayColor()
        return label
    }()

    /// factory method for MessageView
    class func messageView() -> MessageView {
        let messageView = MessageView()
        messageView.label.font = self.MessageFont
        messageView.backgroundColor = UIColor.clearColor()
        messageView.labelEdgeInsets = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 10)
        return messageView
    }

    private(set) var messageViews: [MessageView] = []

    var messages: [String] = [] {
        willSet {
            self.messageViews.forEach{ $0.removeFromSuperview() }
        }

        didSet {
            self.messageViews = messages.map({ (message) -> MessageView in
                let messageView = self.dynamicType.messageView()
                messageView.label.text = message
                self.contentView.addSubview(messageView)
                return messageView
            })
            if let lastMessageView =  self.messageViews.last {
                lastMessageView.showArrow = true
            }
            self.setNeedsLayout()
        }
    }


    func setup() {
        self.contentView.addSubview(self.deliveredLabel)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
}
