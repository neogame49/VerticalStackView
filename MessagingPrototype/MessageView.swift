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
        case LeftSide // without arrow
        case RightSide // without arrow
        case LeftSideWithArrow
        case RightSideWithArrow
    }

    var appearanceMode: AppearanceMode = .LeftSide {
        didSet {
            self.setNeedsLayout()
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
            case .LeftSide: fallthrough
            case .LeftSideWithArrow:
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
        case .LeftSide: fallthrough
        case .LeftSideWithArrow:
            bubbleRect.origin.x += self.arrowWidth
            bubbleRect.size.width -= self.arrowWidth
        case .RightSide: fallthrough
        case .RightSideWithArrow:
            bubbleRect.size.width -= self.arrowWidth
        }

        var cornersToRounding: UIRectCorner = .AllCorners
        switch self.appearanceMode {
        case .LeftSideWithArrow:
            cornersToRounding = [.TopLeft, .TopRight, .BottomRight]
        case.RightSideWithArrow:
            cornersToRounding = [.TopLeft, .TopRight, .BottomLeft]
        default: break
        }
        return UIBezierPath(roundedRect: bubbleRect, byRoundingCorners: cornersToRounding, cornerRadii: CGSize(width: self.bubbleCornerRadius, height: self.bubbleCornerRadius))
    }

    func arrowPathForRect(rect: CGRect) -> UIBezierPath? {
        var firstPoint = CGPointZero
        var secondPoint = CGPointZero
        var thirdPoint = CGPointZero

        switch self.appearanceMode {
        case .LeftSideWithArrow:
            firstPoint = CGPoint(x: rect.origin.x , y: rect.maxY)
            secondPoint = CGPoint(x: rect.origin.x + self.arrowWidth , y: rect.maxY)
            thirdPoint = CGPoint(x: rect.origin.x + self.arrowWidth , y: rect.maxY - self.arrowHeight)
        case .RightSideWithArrow:
            firstPoint = CGPoint(x: rect.maxX, y: rect.maxY)
            secondPoint = CGPoint(x: rect.maxX - self.arrowWidth , y: rect.maxY)
            thirdPoint = CGPoint(x: rect.maxX - self.arrowWidth , y: rect.maxY - self.arrowHeight)
        default:
            return nil // for else cases no need draw  arrow
        }

        let arrowPath = UIBezierPath()
        arrowPath.moveToPoint(firstPoint)
        arrowPath.addLineToPoint(secondPoint)
        arrowPath.addLineToPoint(thirdPoint)
        arrowPath.closePath()
        return arrowPath
    }

}
