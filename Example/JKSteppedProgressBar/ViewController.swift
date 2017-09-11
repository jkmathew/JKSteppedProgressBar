//
//  ViewController.swift
//  JKSteppedProgressBar
//
//  Created by Johnykutty Mathew on 12/09/16.
//  Copyright © 2016 Johnykutty Mathew. All rights reserved.
//

import UIKit
import JKSteppedProgressBar
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
class ViewController: UIViewController {

    @IBOutlet weak var currentTabLabel: UILabel!
    @IBOutlet weak var progressbar: SteppedProgressBar!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressbar.titles = ["Step 1".localized, "Step 2".localized, "Step 3 step again".localized,]
        progressbar.insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 30)
        updateButtons(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func next(_ sender: AnyObject) {
        var tab = progressbar.currentTab
        tab += 1
        updateButtons(tab)
    }

    @IBAction func prev(_ sender: AnyObject) {
        var tab = progressbar.currentTab
        tab -= 1
        updateButtons(tab)
    }
    
    func updateButtons(_ currentTab: Int) {
        nextButton.isEnabled = currentTab < progressbar.titles.count
        prevButton.isEnabled = currentTab > 0
        progressbar.currentTab = currentTab
        currentTabLabel.text = "\(currentTab)"
    }
}

