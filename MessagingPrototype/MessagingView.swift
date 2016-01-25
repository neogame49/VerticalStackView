//
//  MessagingView.swift
//  MessagingPrototype
//
//  Created by Roman on 1/24/16.
//  Copyright © 2016 Roman Shcherbii. All rights reserved.
//

import UIKit

@IBDesignable
class MessagingView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var labelEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)/*UIEdgeInsetsZero*/ {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
        }
    }
    var preferedWidth: CGFloat = 50 {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = UIColor.greenColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: CGRectZero)
        self.setup()
    }
    
    override convenience init(frame: CGRect) {
        self.init()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        self.addSubview(self.label)
        //self.layer.cornerRadius = 15.0
        self.backgroundColor = UIColor.blueColor()
    }
    
    /*override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }*/
    
    override func intrinsicContentSize() -> CGSize {
        //return UIEdgeInsetsInsetRect(self.label.frame, self.labelEdgeInsets).size
        //return self.label.frame.size
        return self.preferedContentSizeForWidth(self.preferedWidth)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let labelFrame = UIEdgeInsetsInsetRect(self.bounds, self.labelEdgeInsets)
        self.label.frame = labelFrame
    }
    
    /*override func updateConstraints() {
        
        self.label.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(label.superview!).inset(self.labelEdgeInsets).priorityHigh()
            /*make.leading.equalTo(self.label.superview!).offset(10).priorityMedium()
            make.trailing.equalTo(self.label.superview!).offset(-10).priorityMedium()
            make.top.equalTo(self.label.superview!).offset(10).priorityMedium()
            make.bottom.equalTo(self.label.superview!).offset(-10).priorityMedium()*/
            
            //make.leading.greaterThanOrEqualTo(self.label.superview!).offset(0).priorityLow()
            //make.trailing.lessThanOrEqualTo(self.label.superview!).offset(0).priorityLow()
            
        }
        
        super.updateConstraints()
    }*/

    func preferedContentSizeForWidth(width: CGFloat) -> CGSize {
        let adjustmendWidth = UIEdgeInsetsInsetRect(CGRect(x: 0, y: 0, width: width, height: 0), self.labelEdgeInsets).width // width adjustment by insets
        let preferedSizeForLabel = self.label.sizeThatFits(CGSize(width: adjustmendWidth, height: CGFloat.max))

        let result = CGSize(width: preferedSizeForLabel.width + self.labelEdgeInsets.left + self.labelEdgeInsets.right, height:
                            preferedSizeForLabel.height + self.labelEdgeInsets.top + self.labelEdgeInsets.bottom)
        return result
    }

}
