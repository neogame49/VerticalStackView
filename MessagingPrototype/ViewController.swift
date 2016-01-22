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
    var strings = ["lkgl;kgkgkgfgkgfk", "r;lggl;;g;f"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(animated: Bool) {
        //
        let labels = self.strings.map { (str) -> UILabel in
            let label = UILabel()
            label.backgroundColor = UIColor.greenColor()
            label.text = str
            return label
        }

        self.stack.views = labels

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

