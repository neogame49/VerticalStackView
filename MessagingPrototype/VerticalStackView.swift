//
//  VerticalStackView.swift
//  MessagingPrototype
//
//  Created by Roman Shcherbii on 1/22/16.
//  Copyright © 2016 Roman Shcherbii. All rights reserved.
//

import UIKit
import SnapKit

@IBDesignable
class VerticalStackView: UIView {

    var views: [UIView] = [] {
        willSet {
            self.views.forEach{ $0.removeFromSuperview() }
        }
        
        didSet {
            self.views.forEach{ self.addSubview($0) }
            self.setNeedsUpdateConstraints()
            self.invalidateIntrinsicContentSize()
        }
    }
    
    var verticalOffset: CGFloat = 5.0 {
        didSet {
            self.setNeedsUpdateConstraints()
        }
    }
    
    var topView: UIView?
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func updateConstraints() {
        self.resetViews()
        super.updateConstraints()
    }

    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }

    override func intrinsicContentSize() -> CGSize {
        var height: CGFloat = 0.0
        var width: CGFloat = 0.0
        
        for view in self.views {
            height += view.frame.height
            if (view.frame.width > width) {
                width = view.frame.width
            }
        }
        
        return CGSize(width: width, height: height)
    }


    func resetViews() {
        self.topView = nil

        for view in self.views.reverse() {
            view.snp_remakeConstraints(closure: { (make) -> Void in
                make.leading.equalTo(view.superview!)
                make.trailing.lessThanOrEqualTo(view.superview!)

                if let topView = self.topView {
                    make.bottom.equalTo(topView.snp_top).offset(-self.verticalOffset)
                } else {
                    make.bottom.equalTo(view.superview!)
                }

                if let first = self.views.first where first === view {
                    make.top.greaterThanOrEqualTo(view.superview!)
                }
                self.topView = view
            })

        }
    }

}
