//
//  ViewController2.swift
//  MessagingPrototype
//
//  Created by Roman on 1/24/16.
//  Copyright © 2016 Roman Shcherbii. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var messagingView: MessagingView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messagingView.labelEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.messagingView.label.text = "kjnfkfkjgfhjgkhfgjhfgjkhjkgf djgkfhjghfghfkj djkfhgkfhgjkfhgj fjgfjkgfjk fjgfjkghjf fjgjfghfj fjghjfghjf fjgfjghjf "
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
