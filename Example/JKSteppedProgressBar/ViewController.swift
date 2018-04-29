//
//  ViewController.swift
//  JKSteppedProgressBar
//
//  Created by Johnykutty Mathew on 12/09/16.
//  Copyright © 2016 Johnykutty Mathew. All rights reserved.
//

import UIKit
import JKSteppedProgressBar

class ViewController: UIViewController {

    @IBOutlet weak var currentTabLabel: UILabel!
    @IBOutlet weak var progressbar: SteppedProgressBar!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var inset: UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 30)
    }
    
    func configureTitleProgressBar() {
        progressbar.insets = inset
        progressbar.stepDrawingMode = .fill
        progressbar.titles = ["Step 1".localized, "Step 2".localized, "Step 3 step again".localized,]
        progressbar.activeStepColors = [
            UIColor.red,
            UIColor.orange,
            UIColor.green,
        ]
    }
    
    // MARK: Misc
    func updateButtons(_ currentTab: Int) {
        nextButton.isEnabled = currentTab < progressbar.titles.count
        prevButton.isEnabled = currentTab > 0
        progressbar.currentTab = currentTab
        currentTabLabel.text = "\(currentTab)"
    }
    
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleProgressBar()
        updateButtons(0)
    }

    // MARK: button actions
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
}

