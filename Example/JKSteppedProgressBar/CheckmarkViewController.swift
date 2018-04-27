//
//  CheckmarkViewController.swift
//  JKSteppedProgressBar_Example
//
//  Created by Etienne Wojahn on 27.04.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import JKSteppedProgressBar

class CheckmarkViewController: UIViewController {

    @IBOutlet weak var currentTabLabel: UILabel!
    @IBOutlet weak var progressbar: SteppedProgressBar!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var inset: UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 30)
    }
    
    func configureTitleProgressBar() {
        progressbar.insets = inset
        progressbar.titles = ["Image 1".localized, "Image 2".localized, "Image 3".localized,]
        progressbar.activeImages = [
            UIImage(named: "check")!,
            UIImage(named: "check")!,
            UIImage(named: "check")!,
        ]
        progressbar.tintActiveImage = true
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
