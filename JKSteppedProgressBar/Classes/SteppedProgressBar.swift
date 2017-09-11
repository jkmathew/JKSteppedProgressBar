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
    // TODO:
    case image
}

@IBDesignable
open class SteppedProgressBar: UIView {

    let paragraphStyle = NSMutableParagraphStyle()

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
    
    private var actualSpacing: CGFloat {
        return (circleSpacing == SteppedProgressBarAutomaticDimension) ? (availableFrame.width - 6.0 - (CGFloat(titles.count) * circleRadius)) / CGFloat(titles.count - 1) : circleSpacing
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
    
    private var languageFactor: CGFloat {
        return (UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft) ? -1 : 1
    }
    override open func awakeFromNib() {
        super.awakeFromNib()
        paragraphStyle.alignment = .center
    }
 
    override open func draw(_ rect: CGRect) {
        let count = titles.count
        let context = UIGraphicsGetCurrentContext()
        
        if currentTab == 0 {
            drawTabs(from: 0, to: count, color: inactiveColor, textColor: inactiveTextColor)
        }
        else if currentTab == count {
            drawTabs(from: 0, to: count, color: activeColor, textColor: activeColor)
        }
        else {
            // Addressing issue #3
            // https://github.com/jkmathew/JKSteppedProgressBar/issues/3
            // Drawing in the order 1.inactive, 2.Line between active and inactive, 3.Active to avoid overlaping issue
            let end = drawTabs(from: currentTab, to: count, color: inactiveColor, textColor: inactiveTextColor).start
            let path = UIBezierPath()
            path.lineWidth = lineWidth
            
            var start = end
            start.x -= languageFactor * actualSpacing
            path.move(to: start)
            path.addLine(to: end)
            context?.setStrokeColor(inactiveColor.cgColor)
            path.stroke()
            
            drawTabs(from: 0, to: currentTab , color: activeColor, textColor: activeColor)
         
        }
    }
    
    @discardableResult
    func drawTabs(from begin: Int, to end: Int, color: UIColor, textColor: UIColor) -> (start: CGPoint, end: CGPoint) {
        let halfX = (CGFloat(titles.count - 1) * (actualSpacing + circleRadius) / 2.0)
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
    
    func draw(step i: Int, path: UIBezierPath, start point: inout CGPoint, textColor: UIColor) {
        //draw circle
        path.move(to: point)
        let buttonRect = circleRect(point, radius: circleRadius)
        let circlePath = UIBezierPath(ovalIn: buttonRect)
        
        var attributes = [NSForegroundColorAttributeName : textColor, NSParagraphStyleAttributeName: paragraphStyle]

        //draw index
        let index =  i
        if stepDrawingMode == .drawIndex {
            let buttonTitle = "\(index + 1)"
            let font = UIFont.boldSystemFont(ofSize: 14.0)
            attributes[NSFontAttributeName] = font
            let attributedButtonTitle = NSAttributedString(string: buttonTitle, attributes: attributes)
            draw(string: attributedButtonTitle, center: point)
        }
        path.append(circlePath)
        
        var titleCenter = point
        titleCenter.y += circleRadius * 0.75 + titleOffset
        let title = titles[index]
        attributes[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 12.0)
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        draw(string: attributedTitle, center: titleCenter)
        
        point.x += languageFactor * circleRadius / 2.0
        path.move(to: point)
        
    }
    
    func draw(string: NSAttributedString, center: CGPoint) {
        var rect = string.boundingRect(with: CGSize(width: 1000, height: 1000), options: .usesFontLeading, context: nil)
        let size = rect.size
        let origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0)
        rect.origin = origin
        string.draw(in: rect)
        
    }
    
    func circleRect(_ center: CGPoint, radius: CGFloat) -> CGRect {
        let halfR = radius / 2.0
        let rect = CGRect(x: center.x - halfR, y: center.y - halfR, width: radius, height: radius)
        return rect
    }

}
