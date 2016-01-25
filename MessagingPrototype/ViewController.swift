//
//  ViewController.swift
//  MessagingPrototype
//
//  Created by Roman Shcherbii on 1/22/16.
//  Copyright © 2016 Roman Shcherbii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {



    @IBOutlet weak var stack: VerticalStackView!
    var strings = ["thirty label", "second label", "first label", "long text ckvkfjgfjgfjgfjgbv bnbfjgbfhgfhjgb jdffhjfhj djfdjhfh djfhjdfhj djhfjh"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        //
        print(self.view.translatesAutoresizingMaskIntoConstraints)
        let labels = self.strings.map { (str) -> MessagingView in
            let mView = MessagingView()

            mView.label.text = str
            //mView.labelEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
            return mView
        }

        self.stack.views = labels

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

