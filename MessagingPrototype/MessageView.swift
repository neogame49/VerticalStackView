//
//  MessagingView.swift
//  MessagingPrototype
//
//  Created by Roman on 1/24/16.
//

import UIKit

@IBDesignable
class MessageView: UIView {
    enum  AppearanceMode {
        /// mode with offset from the left side. If showArrow equal true, arrow will be drawed on the left side.
        case LeftSide
        /// mode with offset from the right side. If showArrow equal true, arrow will be drawed on the right side.
        case RightSide
    }

    var appearanceMode: AppearanceMode = .LeftSide {
        didSet {
            self.setNeedsLayout()
            self.setNeedsDisplay()
        }
    }

    @IBInspectable
    var showArrow: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable
    var bubbleCornerRadius: CGFloat = 10 {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable
    var bubbleColor: UIColor = UIColor.blueColor() {
        didSet {
            self.setNeedsDisplay()
        }
    }

    var labelEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
        }
    }

    @IBInspectable
    var arrowWidth: CGFloat = 5 {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
        }
    }

    @IBInspectable
    var arrowHeight: CGFloat = 5 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Inits
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(self.label)
    }

    // MARK: - Layout part
    override func intrinsicContentSize() -> CGSize {
        return self.preferredContentSizeForWidth(self.frame.size.width)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var labelFrame = UIEdgeInsetsInsetRect(self.bounds, self.labelEdgeInsets)
        labelFrame.size.width -= self.arrowWidth
        switch self.appearanceMode {
            case .LeftSide:
                labelFrame.origin.x += self.arrowWidth
            default:
                break
        }
        self.label.frame = labelFrame
    }


    func preferredContentSizeForWidth(width: CGFloat) -> CGSize {
        let allowedWidthForLabel = UIEdgeInsetsInsetRect(CGRect(x: 0, y: 0, width: width, height: 0), self.labelEdgeInsets).width - self.arrowWidth // adjustmented width  by insets and arrow width
        let preferredSizeForLabel = self.label.sizeThatFits(CGSize(width: allowedWidthForLabel, height: CGFloat.max))

        return  CGSize(width: preferredSizeForLabel.width + self.labelEdgeInsets.left + self.labelEdgeInsets.right + self.arrowWidth, height:
                            preferredSizeForLabel.height + self.labelEdgeInsets.top + self.labelEdgeInsets.bottom)
    }

    // MARK: - Drawing part
    override func drawRect(rect: CGRect) {
        let pathToDraw = self.bubblePathForRect(rect)
        if let arrowPath = self.arrowPathForRect(rect) {
            pathToDraw.appendPath(arrowPath)
        }
        self.bubbleColor.setFill()
        pathToDraw.fill()
    }

    func bubblePathForRect(rect: CGRect) -> UIBezierPath {
        var bubbleRect = rect

        switch self.appearanceMode {
            case .LeftSide:
                bubbleRect.origin.x += self.arrowWidth
                bubbleRect.size.width -= self.arrowWidth
            case .RightSide:
                bubbleRect.size.width -= self.arrowWidth
        }

        var cornersToRounding: UIRectCorner = .AllCorners
        if self.showArrow {
            switch self.appearanceMode {
                case .LeftSide:
                    cornersToRounding = [.TopLeft, .TopRight, .BottomRight]
                case.RightSide:
                    cornersToRounding = [.TopLeft, .TopRight, .BottomLeft]
            }
        }
        return UIBezierPath(roundedRect: bubbleRect, byRoundingCorners: cornersToRounding, cornerRadii: CGSize(width: self.bubbleCornerRadius, height: self.bubbleCornerRadius))
    }

    func arrowPathForRect(rect: CGRect) -> UIBezierPath? {
        guard self.showArrow else { return nil }

        var firstPoint = CGPointZero
        var secondPoint = CGPointZero
        var thirdPoint = CGPointZero

        switch self.appearanceMode {
            case .LeftSide:
                firstPoint = CGPoint(x: rect.origin.x , y: rect.maxY)
                secondPoint = CGPoint(x: rect.origin.x + self.arrowWidth , y: rect.maxY)
                thirdPoint = CGPoint(x: rect.origin.x + self.arrowWidth , y: rect.maxY - self.arrowHeight)
            case .RightSide:
                firstPoint = CGPoint(x: rect.maxX, y: rect.maxY)
                secondPoint = CGPoint(x: rect.maxX - self.arrowWidth , y: rect.maxY)
                thirdPoint = CGPoint(x: rect.maxX - self.arrowWidth , y: rect.maxY - self.arrowHeight)
        }

        let arrowPath = UIBezierPath()
        arrowPath.moveToPoint(firstPoint)
        arrowPath.addLineToPoint(secondPoint)
        arrowPath.addLineToPoint(thirdPoint)
        arrowPath.closePath()
        return arrowPath
    }

}
