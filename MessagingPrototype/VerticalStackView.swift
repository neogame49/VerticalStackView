//
//  VerticalStackView.swift
//  MessagingPrototype
//
//  Created by Roman Shcherbii on 1/22/16.
//  Copyright © 2016 Roman Shcherbii. All rights reserved.
//

import UIKit
import SnapKit

class VerticalStackView: UIView {

    var views: [UIView] = [] {
        didSet {
            self.updateConstraints()
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
        super.updateConstraints()
        self.resetViews()
    }

    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }

    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 200, height: 200)
    }


    func resetViews() {
        self.views.forEach{ $0.removeFromSuperview() }
        self.topView = nil

        for view in self.views.reverse() {

            self.addSubview(view)
            view.snp_remakeConstraints(closure: { (make) -> Void in
                make.left.equalTo(view.superview!).offset(0)
                make.right.equalTo(view.superview!).offset(0)

                if let topView = self.topView {
                    make.bottom.equalTo(topView).offset(0)
                } else {
                    make.bottom.equalTo(view.superview!).offset(0)
                }

                if let first = self.views.first where first === view {
                    //make.top.equalTo(view.superview!).offset(0)
                }
                self.topView = view
            })

        }
    }

}
