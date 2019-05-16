//
//  SteppedProgressBar.swift
//  JKSteppedProgressBar
//
//  Created by Johnykutty Mathew on 12/09/16.
//  Copyright © 2016 Johnykutty Mathew. All rights reserved.
//

import UIKit

public let SteppedProgressBarAutomaticDimension: CGFloat = -1

public enum StepDrawingMode: Int {
    case fill
    case drawIndex
    case image
}

@IBDesignable
open class SteppedProgressBar: UIView {
    
    // MARK: PROPERTIES

    let paragraphStyle = NSMutableParagraphStyle()
    
    // MARK: IBInspectable Properties

    @IBInspectable open var activeColor: UIColor = UIColor.green {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var inactiveColor: UIColor = UIColor.gray {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var inactiveTextColor: UIColor = UIColor.gray {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var circleRadius: CGFloat = 20 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    // Addressing issue #3
    // https://github.com/jkmathew/JKSteppedProgressBar/issues/3
    @IBInspectable open var titleOffset: CGFloat = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var circleSpacing: CGFloat = SteppedProgressBarAutomaticDimension {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var lineWidth: CGFloat = 2 {
        didSet {
            self.setNeedsDisplay()
        }
    }

    
    @IBInspectable open var currentTab: Int = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    // Changes the tint color of theactiveImages image to the activeColor
    @IBInspectable open  var tintActiveImage = false
    @IBInspectable open var justCheckCompleted = true
    
    open var stepDrawingMode: StepDrawingMode = .drawIndex {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    open var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    open var titles = ["One", "Two","Three", "Four","Five", "Six"] {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var availableFrame: CGRect {
        var correctedFrame = bounds
        correctedFrame.origin.x = insets.left
        correctedFrame.origin.y = insets.top
        
        correctedFrame.size.width -= insets.left + insets.right
        correctedFrame.size.height -= insets.top + insets.bottom
        
        return correctedFrame
    }
    
    /*
     This will redraw and change color for the steps which are done. For example, if we set this as Red, Orange,
     Yellow, Green, then when you are at step one, it(circle and lines to circle) be Red, and when you are in second
     step, line and circles till that step(circle 1, line 1, circle 2) will be Orange, and so on.., then, when you are
     in fourth step it wil be Green from start circle to end circle. There by you can show the user a level of
     completion if wanted through colors.
     */
    
    open var activeStepColors: [UIColor]? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    // MARK: Image Helper properties
    
    /*
     * setting images will only show the images instead of any text mentioned
     */
    open var images: [UIImage]? {
        didSet {
            stepDrawingMode = .image
            self.setNeedsDisplay()
        }
    }
    
    open var activeImages: [UIImage]? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    
    // MARK: Private Properties
    private var actualSpacing: CGFloat {
        return (circleSpacing == SteppedProgressBarAutomaticDimension)
            ? (availableFrame.width - 6.0 - (CGFloat(numberOfItems) * circleRadius)) / CGFloat(numberOfItems - 1)
            : circleSpacing
    }
    
    private var languageFactor: CGFloat {
        return (UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft) ? -1 : 1
    }
    
    private var numberOfItems: Int {
        return stepDrawingMode == .image ? (images ?? []).count : titles.count
    }
    
    
    // MARK: METHODS
    
    // MARK: View Lifecycle Methods
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        paragraphStyle.alignment = .center
    }
 
    override open func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        if currentTab == 0 {
            drawTabs(from: 0, to: numberOfItems, color: inactiveColor, textColor: inactiveTextColor)
        } else if currentTab == numberOfItems {
            drawTabs(from: 0, to: numberOfItems, color: activeStepColor(currentTab), textColor: activeStepColor(currentTab))
        }
        else {
            // Addressing issue #3
            // https://github.com/jkmathew/JKSteppedProgressBar/issues/3
            // Drawing in the order 1.inactive, 2.Line between active and inactive, 3.Active to avoid overlaping issue
            let end = drawTabs(from: currentTab, to: numberOfItems, color: inactiveColor, textColor: inactiveTextColor).start
            let path = UIBezierPath()
            path.lineWidth = lineWidth
            
            var start = end
            start.x -= languageFactor * actualSpacing
            path.move(to: start)
            path.addLine(to: end)
            context?.setStrokeColor(inactiveColor.cgColor)
            path.stroke()
            
            drawTabs(from: 0, to: currentTab , color: activeStepColor(currentTab), textColor: activeStepColor(currentTab))
         
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
    }
    
    // MARK: Draw Helper Methods
    
    @discardableResult
    func drawTabs(from begin: Int, to end: Int, color: UIColor, textColor: UIColor) -> (start: CGPoint, end: CGPoint) {
        let halfX = (CGFloat(numberOfItems - 1) * (actualSpacing + circleRadius) / 2.0)
        let startX =  availableFrame.midX - languageFactor * halfX
        let x = startX + languageFactor * (actualSpacing + circleRadius) * CGFloat(begin)
        var point = CGPoint(x: x, y: availableFrame.midY)
        var start = point
        start.x -= languageFactor * circleRadius / 2.0
        
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        for i in begin..<end {
            draw(step: i, path: path, start : &point, textColor: textColor)
            if i != (end - 1) {
                //draw trailinng line
                point.x += languageFactor * actualSpacing
                path.addLine(to: point)
                point.x += languageFactor * circleRadius / 2.0
            }
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(color.cgColor)
        context?.setFillColor(color.cgColor)
        path.stroke()
        if stepDrawingMode == .fill {
            path.fill()
        }

        return (start: start, end: point)
    }
    
    /*
     * Draws the images with a predefined inset
     */
    func drawImage(step i: Int, at rect: CGRect) {
        guard ( images ?? [] ).count > i else {
            return
        }
        ( images ?? [] )[i].draw(inside: rect)
    }
    
    /*
     * Draws the successImage. If tintActiveImage change the tint of the UIImage
     */
    func drawSuccessImage(step i: Int, at rect: CGRect) {
        guard ( activeImages ?? [] ).count > i else {
            drawImage(step: i, at: rect)
            return
        }
        (tintActiveImage
            ? ( activeImages ?? [] )[i].imageWithColor(activeColor)
            : ( activeImages ?? [] )[i])
                .draw(inside: rect)
    }
    
    func draw(step i: Int, path: UIBezierPath, start point: inout CGPoint, textColor: UIColor) {
        let buttonRect = CGRect.make(center: point, diameter: circleRadius)
        
        // Check if images are set and decide what image to draw
        if ( images ?? [] ).count > i || ( activeImages ?? [] ).count > i {
            if (i < currentTab - (justCheckCompleted ? 1 : 0)) {
                drawSuccessImage(step: i, at: buttonRect)
            } else {
                drawImage(step: i, at: buttonRect)
            }
        }
        
        //draw circle
        path.move(to: point)
        let circlePath = UIBezierPath(ovalIn: buttonRect)
        
        #if swift(>=4.0)
        var attributes = [NSAttributedString.Key.foregroundColor : textColor, NSAttributedString.Key.paragraphStyle: paragraphStyle]
        #else
        var attributes = [NSForegroundColorAttributeName : textColor, NSParagraphStyleAttributeName: paragraphStyle]
        #endif
        
        let index =  i
        
        // If a successImage was drawn dont draw text under it
        if index >= currentTab - (justCheckCompleted ? 1 : 0) || ( activeImages ?? [] ).count <= index {
            //draw index
            if stepDrawingMode == .drawIndex  {
                let buttonTitle = "\(index + 1)"
                let font = UIFont.boldSystemFont(ofSize: 14.0)
                #if swift(>=4.0)
                attributes[NSAttributedString.Key.font] = font
                #else
                attributes[NSFontAttributeName] = font
                #endif
                let attributedString = NSAttributedString(string: buttonTitle, attributes: attributes)
                attributedString.draw(center: point)
            }
        }
        
        path.append(circlePath)
        
        var titleCenter = point
        titleCenter.y += circleRadius * 0.75 + titleOffset
        let title = titles[index]
        #if swift(>=4.0)
        attributes[NSAttributedString.Key.font] = UIFont.boldSystemFont(ofSize: 12.0)
        #else
            attributes[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 12.0)
        #endif
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        attributedString.draw(center: titleCenter)
        
        point.x += languageFactor * circleRadius / 2.0
        path.move(to: point)
        
    }
}

private extension SteppedProgressBar {
    
    /* Returns the active step color to the caller, if its mentioned in activeStepColors array. If not return the
     activeColor */
    func activeStepColor(_ tabIndex: Int) -> UIColor {
        var activeStepColor = activeColor
        if let activeStepColors = activeStepColors, tabIndex - 1 < activeStepColors.count {
            activeStepColor = activeStepColors[tabIndex - 1]
        }
        return activeStepColor
    }
}
