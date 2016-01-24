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
            self.setNeedsUpdateConstraints()
            self.invalidateIntrinsicContentSize()
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
        self.layer.cornerRadius = 15.0
        self.backgroundColor = UIColor.redColor()
    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    override func intrinsicContentSize() -> CGSize {
        //return UIEdgeInsetsInsetRect(self.label.frame, self.labelEdgeInsets).size
        //return self.label.frame.size
        return CGSize(width: 10, height: 10)
    }
    
    override func updateConstraints() {
        
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
    }

}
