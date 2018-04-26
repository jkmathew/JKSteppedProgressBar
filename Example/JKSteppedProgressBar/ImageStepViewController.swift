//
//  ImageStepViewController.swift
//  JKSteppedProgressBar_Example
//
//  Created by Jayahari Vavachan on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import JKSteppedProgressBar

class ImageStepViewController: UIViewController {
    
    @IBOutlet weak var currentTabLabel: UILabel!
    @IBOutlet weak var progressbarWithImages: SteppedProgressBar!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var inset: UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 30)
    }
    
    // MARK: UI configure methods
    func configureProgressBarWithImages() {
        progressbarWithImages.insets = inset
        progressbarWithImages.titles = ["Image 1".localized, "Image 2".localized, "Image 3".localized,]
        progressbarWithImages.images = [
            UIImage(named: "DaisyDuck")!,
            UIImage(named: "MickeyMouse")!,
            UIImage(named: "MinnieMouse")!,
        ]
    }
    
    // MARK: Misc
    func updateButtons(_ currentTab: Int) {
        nextButton.isEnabled = currentTab < progressbarWithImages.titles.count
        prevButton.isEnabled = currentTab > 0
        progressbarWithImages.currentTab = currentTab
        currentTabLabel.text = "\(currentTab)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureProgressBarWithImages()
        updateButtons(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: button actions
    @IBAction func next(_ sender: AnyObject) {
        var tab = progressbarWithImages.currentTab
        tab += 1
        updateButtons(tab)
    }
    
    @IBAction func prev(_ sender: AnyObject) {
        var tab = progressbarWithImages.currentTab
        tab -= 1
        updateButtons(tab)
    }

}
