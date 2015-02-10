//
//  CEMKit.swift
//  CEMKit-Swift
//
//  Created by Cem Olcay on 05/11/14.
//  Copyright (c) 2014 Cem Olcay. All rights reserved.
//

import Foundation
import UIKit


// MARK: - AppDelegate

// let APPDELEGATE: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate



// MARK: - UIView

let UIViewAnimationDuration: NSTimeInterval = 1
let UIViewAnimationSpringDamping: CGFloat = 0.5
let UIViewAnimationSpringVelocity: CGFloat = 0.5


extension UIView {
    
    // MARK: Custom Initilizer
    
    convenience init (x: CGFloat,
        y: CGFloat,
        w: CGFloat,
        h: CGFloat) {
            self.init (frame: CGRect (x: x, y: y, width: w, height: h))
    }

    convenience init (superView: UIView) {
        self.init (frame: CGRect (origin: CGPointZero, size: superView.size))
    }
}


// MARK: Frame Extensions

extension UIView {
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        } set (value) {
            self.frame = CGRect (x: value, y: self.y, width: self.w, height: self.h)
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        } set (value) {
            self.frame = CGRect (x: self.x, y: value, width: self.w, height: self.h)
        }
    }
    
    var w: CGFloat {
        get {
            return self.frame.size.width
        } set (value) {
            self.frame = CGRect (x: self.x, y: self.y, width: value, height: self.h)
        }
    }
    
    var h: CGFloat {
        get {
            return self.frame.size.height
        } set (value) {
            self.frame = CGRect (x: self.x, y: self.y, width: self.w, height: value)
        }
    }
    
    
    var left: CGFloat {
        get {
            return self.x
        } set (value) {
            self.x = value
        }
    }
    
    var right: CGFloat {
        get {
            return self.x + self.w
        } set (value) {
            self.x = value - self.w
        }
    }
    
    var top: CGFloat {
        get {
            return self.y
        } set (value) {
            self.y = value
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.y + self.h
        } set (value) {
            self.y = value - self.h
        }
    }
    
    
    var position: CGPoint {
        get {
            return self.frame.origin
        } set (value) {
            self.frame = CGRect (origin: value, size: self.frame.size)
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        } set (value) {
            self.frame = CGRect (origin: self.frame.origin, size: value)
        }
    }
    
    
    func leftWithOffset (offset: CGFloat) -> CGFloat {
        return self.left - offset
    }
    
    func rightWithOffset (offset: CGFloat) -> CGFloat {
        return self.right + offset
    }
    
    func topWithOffset (offset: CGFloat) -> CGFloat {
        return self.top - offset
    }
    
    func bottomWithOffset (offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }
    
}


// MARK: Transform Extensions

extension UIView {
    
    func setRotationX (x: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, degreesToRadians(x), 1.0, 0.0, 0.0)
        
        self.layer.transform = transform
    }
    
    func setRotationY (y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, degreesToRadians(y), 0.0, 1.0, 0.0)
        
        self.layer.transform = transform
    }
    
    func setRotationZ (z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, degreesToRadians(z), 0.0, 0.0, 1.0)
        
        self.layer.transform = transform
    }
    
    func setRotation (
        x: CGFloat,
        y: CGFloat,
        z: CGFloat) {
            var transform = CATransform3DIdentity
            transform.m34 = 1.0 / -1000.0
            transform = CATransform3DRotate(transform, degreesToRadians(x), 1.0, 0.0, 0.0)
            transform = CATransform3DRotate(transform, degreesToRadians(y), 0.0, 1.0, 0.0)
            transform = CATransform3DRotate(transform, degreesToRadians(z), 0.0, 0.0, 1.0)
            
            self.layer.transform = transform
    }
    
    
    func setScale (
        x: CGFloat,
        y: CGFloat) {
            var transform = CATransform3DIdentity
            transform.m34 = 1.0 / -1000.0
            transform = CATransform3DScale(transform, x, y, 1)
            
            self.layer.transform = transform
    }
    
}


// MARK: Layer Extensions

extension UIView {
    
    func setAnchorPosition (anchorPosition: AnchorPosition) {
        println(anchorPosition.rawValue)
        self.layer.anchorPoint = anchorPosition.rawValue
    }
    
    func setCornerRadius (radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func addShadow (
        offset: CGSize,
        radius: CGFloat,
        color: UIColor,
        opacity: Float,
        cornerRadius: CGFloat? = nil) {
            self.layer.shadowOffset = offset
            self.layer.shadowRadius = radius
            self.layer.shadowOpacity = opacity
            self.layer.shadowColor = color.CGColor
            
            if let r = cornerRadius {
                self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).CGPath
            }
    }
    
    func addBorder (
        width: CGFloat,
        color: UIColor) {
            self.layer.borderWidth = width
            self.layer.borderColor = color.CGColor
            self.layer.masksToBounds = true
    }
    
    func drawCircle (
        fillColor: UIColor,
        strokeColor: UIColor,
        strokeWidth: CGFloat) {
            let path = UIBezierPath (roundedRect: CGRect (x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
            
            let shapeLayer = CAShapeLayer ()
            shapeLayer.path = path.CGPath
            shapeLayer.fillColor = fillColor.CGColor
            shapeLayer.strokeColor = strokeColor.CGColor
            shapeLayer.lineWidth = strokeWidth
            
            self.layer.addSublayer(shapeLayer)
    }
    
    func drawStroke (
        width: CGFloat,
        color: UIColor) {
            let path = UIBezierPath (roundedRect: CGRect (x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
            
            let shapeLayer = CAShapeLayer ()
            shapeLayer.path = path.CGPath
            shapeLayer.fillColor = UIColor.clearColor().CGColor
            shapeLayer.strokeColor = color.CGColor
            shapeLayer.lineWidth = width
            
            self.layer.addSublayer(shapeLayer)
    }
    
    func drawArc (
        from: CGFloat,
        to: CGFloat,
        clockwise: Bool,
        width: CGFloat,
        fillColor: UIColor,
        strokeColor: UIColor,
        lineCap: String) {
            let path = UIBezierPath (arcCenter: self.center, radius: self.w/2, startAngle: degreesToRadians(from), endAngle: degreesToRadians(to), clockwise: clockwise)
            
            let shapeLayer = CAShapeLayer ()
            shapeLayer.path = path.CGPath
            shapeLayer.fillColor = fillColor.CGColor
            shapeLayer.strokeColor = strokeColor.CGColor
            shapeLayer.lineWidth = width
            
            self.layer.addSublayer(shapeLayer)
    }
    
}


// MARK: Animation Extensions

extension UIView {
    
    func spring (
        animations: (()->Void),
        completion: ((Bool)->Void)? = nil) {
            spring(UIViewAnimationDuration,
                animations: animations,
                completion: completion)
    }
    
    func spring (
        duration: NSTimeInterval,
        animations: (()->Void),
        completion: ((Bool)->Void)? = nil) {
            UIView.animateWithDuration(UIViewAnimationDuration,
                delay: 0,
                usingSpringWithDamping: UIViewAnimationSpringDamping,
                initialSpringVelocity: UIViewAnimationSpringVelocity,
                options: UIViewAnimationOptions.AllowAnimatedContent,
                animations: animations,
                completion: completion)
    }
    
    func animate (
        duration: NSTimeInterval,
        animations: (()->Void),
        completion: ((Bool)->Void)? = nil) {
            UIView.animateWithDuration(duration,
                animations: animations,
                completion: completion)
    }
    
    func animate (
        animations: (()->Void),
        completion: ((Bool)->Void)? = nil) {
            animate(
                UIViewAnimationDuration,
                animations: animations,
                completion: completion)
    }
    
    func pop () {
        setScale(1.1, y: 1.1)
        spring(0.2) {
            [unowned self] in
            self.setScale(1, y: 1)
        }
    }
}


// MARK: Render Extensions

extension UIView {
    
    func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, 0.0)
        drawViewHierarchyInRect(bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
    }
}


// MARK: Gesture Extensions

extension UIView {
    
    func addTapGesture (
        tapNumber: Int,
        target: AnyObject, action: Selector) {
            let tap = UITapGestureRecognizer (target: target, action: action)
            tap.numberOfTapsRequired = tapNumber
            addGestureRecognizer(tap)
            userInteractionEnabled = true
    }
    
    func addTapGesture (
        tapNumber: Int,
        action: ((UITapGestureRecognizer)->())?) {
            let tap = BlockTap (tapCount: tapNumber,
                fingerCount: 1,
                action: action)
            addGestureRecognizer(tap)
            userInteractionEnabled = true
    }
    
    func addSwipeGesture (
        direction: UISwipeGestureRecognizerDirection,
        numberOfTouches: Int,
        target: AnyObject,
        action: Selector) {
            let swipe = UISwipeGestureRecognizer (target: target, action: action)
            swipe.direction = direction
            swipe.numberOfTouchesRequired = numberOfTouches
            addGestureRecognizer(swipe)
            userInteractionEnabled = true
    }
    
    func addSwipeGesture (
        direction: UISwipeGestureRecognizerDirection,
        numberOfTouches: Int,
        action: ((UISwipeGestureRecognizer)->())?) {
            let swipe = BlockSwipe (direction: direction,
                fingerCount: numberOfTouches,
                action: action)
            addGestureRecognizer(swipe)
            userInteractionEnabled = true
    }
    
    func addPanGesture (
        target: AnyObject,
        action: Selector) {
            let pan = UIPanGestureRecognizer (target: target, action: action)
            addGestureRecognizer(pan)
            userInteractionEnabled = true
    }
    
    func addPanGesture (action: ((UIPanGestureRecognizer)->())?) {
        let pan = BlockPan (action: action)
        addGestureRecognizer(pan)
        userInteractionEnabled = true
    }
    
    func addPinchGesture (
        target: AnyObject,
        action: Selector) {
            let pinch = UIPinchGestureRecognizer (target: target, action: action)
            addGestureRecognizer(pinch)
            userInteractionEnabled = true
    }
    
    func addPinchGesture (action: ((UIPinchGestureRecognizer)->())?) {
        let pinch = BlockPinch (action: action)
        addGestureRecognizer(pinch)
        userInteractionEnabled = true
    }
    
    func addLongPressGesture (
        target: AnyObject,
        action: Selector) {
            let longPress = UILongPressGestureRecognizer (target: target, action: action)
            addGestureRecognizer(longPress)
            userInteractionEnabled = true
    }
    
    func addLongPressGesture (action: ((UILongPressGestureRecognizer)->())?) {
        let longPress = BlockLongPress (action: action)
        addGestureRecognizer(longPress)
        userInteractionEnabled = true
    }
}



// MARK: - UIViewController

extension UIViewController {
    
    var top: CGFloat {
        get {
            
            if let me = self as? UINavigationController {
                return me.visibleViewController.top
            }
            
            if let nav = self.navigationController {
                if nav.navigationBarHidden {
                    return view.top
                } else {
                    return nav.navigationBar.bottom
                }
            } else {
                return view.top
            }
        }
    }
    
    var bottom: CGFloat {
        get {
            
            if let me = self as? UINavigationController {
                return me.visibleViewController.bottom
            }
            
            if let tab = tabBarController {
                if tab.tabBar.hidden {
                    return view.bottom
                } else {
                    return tab.tabBar.top
                }
            } else {
                return view.bottom
            }
        }
    }
    
    
    var tabBarHeight: CGFloat {
        get {
            
            if let me = self as? UINavigationController {
                return me.visibleViewController.tabBarHeight
            }
            
            if let tab = self.tabBarController {
                return tab.tabBar.frame.size.height
            }
            
            return 0
        }
    }
    
    
    var navigationBarHeight: CGFloat {
        get {
            
            if let me = self as? UINavigationController {
                return me.visibleViewController.navigationBarHeight
            }
            
            if let nav = self.navigationController {
                return nav.navigationBar.h
            }
            
            return 0
        }
    }
    
    var navigationBarColor: UIColor? {
        get {
            
            if let me = self as? UINavigationController {
                return me.visibleViewController.navigationBarColor
            }
            
            return navigationController?.navigationBar.tintColor
        } set (value) {
            navigationController?.navigationBar.barTintColor = value
        }
    }
    
    var navBar: UINavigationBar? {
        get {
            return navigationController?.navigationBar
        }
    }
    
    
    var applicationFrame: CGRect {
        get {
            return CGRect (x: view.x, y: top, width: view.w, height: bottom - top)
        }
    }
    
    
    func push (vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pop () {
        navigationController?.popViewControllerAnimated(true)
    }

    func present (vc: UIViewController) {
        presentViewController(vc, animated: true, completion: nil)
    }
    
    func dismiss (completion: (()->Void)?) {
        dismissViewControllerAnimated(true, completion: completion)
    }
}



// MARK: - UIScrollView

extension UIScrollView {
    
    var contentHeight: CGFloat {
        get {
            return contentSize.height
        } set (value) {
            contentSize = CGSize (width: contentSize.width, height: value)
        }
    }
    
    var contentWidth: CGFloat {
        get {
            return contentSize.height
        } set (value) {
            contentSize = CGSize (width: value, height: contentSize.height)
        }
    }
    
    var offsetX: CGFloat {
        get {
            return contentOffset.x
        } set (value) {
            contentOffset = CGPoint (x: value, y: contentOffset.y)
        }
    }
    
    var offsetY: CGFloat {
        get {
            return contentOffset.y
        } set (value) {
            contentOffset = CGPoint (x: contentOffset.x, y: value)
        }
    }
}



// MARK: - UILabel

private var UILabelAttributedStringArray: UInt8 = 0

extension UILabel {
    
    var attributedStrings: [NSAttributedString]? {
        get {
            return objc_getAssociatedObject(self, &UILabelAttributedStringArray) as? [NSAttributedString]
        } set (value) {
            objc_setAssociatedObject(self, &UILabelAttributedStringArray, value, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
    }
    
    
    func addAttributedString (
        text: String,
        color: UIColor,
        font: UIFont) {
            var att = NSAttributedString (text: text, color: color, font: font)
            self.addAttributedString(att)
    }
    
    func addAttributedString (attributedString: NSAttributedString) {
        var att: NSMutableAttributedString?
        
        if let a = self.attributedText {
            att = NSMutableAttributedString (attributedString: a)
            att?.appendAttributedString(attributedString)
        } else {
            att = NSMutableAttributedString (attributedString: attributedString)
            attributedStrings = []
        }
        
        attributedStrings?.append(attributedString)
        self.attributedText = NSAttributedString (attributedString: att!)
    }
    
    
    
    func updateAttributedStringAtIndex (index: Int,
        attributedString: NSAttributedString) {
            
            if let att = attributedStrings?[index] {
                attributedStrings?.removeAtIndex(index)
                attributedStrings?.insert(attributedString, atIndex: index)
                
                let updated = NSMutableAttributedString ()
                for att in attributedStrings! {
                    updated.appendAttributedString(att)
                }
                
                self.attributedText = NSAttributedString (attributedString: updated)
            }
    }
    
    func updateAttributedStringAtIndex (index: Int,
        newText: String) {
            if let att = attributedStrings?[index] {
                let newAtt = NSMutableAttributedString (string: newText)
                
                att.enumerateAttributesInRange(NSMakeRange(0, countElements(att.string)-1),
                    options: NSAttributedStringEnumerationOptions.LongestEffectiveRangeNotRequired,
                    usingBlock: { (attribute, range, stop) -> Void in
                        for (key, value) in attribute {
                            newAtt.addAttribute(key as String, value: value, range: range)
                        }
                    }
                )
                
                updateAttributedStringAtIndex(index, attributedString: newAtt)
            }
    }
    
    
    
    func getEstimatedSize (
        width: CGFloat = CGFloat.max,
        height: CGFloat = CGFloat.max) -> CGSize {
            return sizeThatFits(CGSize(width: width, height: height))
    }
    
    func getEstimatedHeight () -> CGFloat {
        return sizeThatFits(CGSize(width: w, height: CGFloat.max)).height
    }
    
    func getEstimatedWidth () -> CGFloat {
        return sizeThatFits(CGSize(width: CGFloat.max, height: h)).width
    }
    
    
    
    func fitHeight () {
        self.h = getEstimatedHeight()
    }
    
    func fitWidth () {
        self.w = getEstimatedWidth()
    }
    
    func fitSize () {
        self.fitWidth()
        self.fitHeight()
        sizeToFit()
    }
    
    
    
    // Text, TextColor, TextAlignment, Font
    
    convenience init (
        frame: CGRect,
        text: String,
        textColor: UIColor,
        textAlignment: NSTextAlignment,
        font: UIFont) {
            self.init(frame: frame)
            self.text = text
            self.textColor = textColor
            self.textAlignment = textAlignment
            self.font = font
            
            self.numberOfLines = 0
    }
    
    convenience init (
        x: CGFloat,
        y: CGFloat,
        width: CGFloat,
        height: CGFloat,
        text: String,
        textColor: UIColor,
        textAlignment: NSTextAlignment,
        font: UIFont) {
            self.init(frame: CGRect (x: x, y: y, width: width, height: height))
            self.text = text
            self.textColor = textColor
            self.textAlignment = textAlignment
            self.font = font
            
            self.numberOfLines = 0
    }
    
    convenience init (
        x: CGFloat,
        y: CGFloat,
        width: CGFloat,
        text: String,
        textColor: UIColor,
        textAlignment: NSTextAlignment,
        font: UIFont) {
            self.init(frame: CGRect (x: x, y: y, width: width, height: 10.0))
            self.text = text
            self.textColor = textColor
            self.textAlignment = textAlignment
            self.font = font
            
            self.numberOfLines = 0
            self.fitHeight()
    }
    
    convenience init (
        x: CGFloat,
        y: CGFloat,
        width: CGFloat,
        padding: CGFloat,
        text: String,
        textColor: UIColor,
        textAlignment: NSTextAlignment,
        font: UIFont) {
            self.init(frame: CGRect (x: x, y: y, width: width, height: 10.0))
            self.text = text
            self.textColor = textColor
            self.textAlignment = textAlignment
            self.font = font
            
            self.numberOfLines = 0
            self.h = self.getEstimatedHeight() + 2*padding
    }
    
    convenience init (
        x: CGFloat,
        y: CGFloat,
        text: String,
        textColor: UIColor,
        textAlignment: NSTextAlignment,
        font: UIFont) {
            self.init(frame: CGRect (x: x, y: y, width: 10.0, height: 10.0))
            self.text = text
            self.textColor = textColor
            self.textAlignment = textAlignment
            self.font = font
            
            self.numberOfLines = 0
            self.fitSize()
    }
    
    
    
    // AttributedText
    
    convenience init (
        frame: CGRect,
        attributedText: NSAttributedString,
        textAlignment: NSTextAlignment) {
            self.init(frame: frame)
            self.attributedText = attributedText
            self.textAlignment = textAlignment
            
            self.numberOfLines = 0
    }
    
    convenience init (
        x: CGFloat,
        y: CGFloat,
        width: CGFloat,
        height: CGFloat,
        attributedText: NSAttributedString,
        textAlignment: NSTextAlignment) {
            self.init(frame: CGRect (x: x, y: y, width: width, height: height))
            self.attributedText = attributedText
            self.textAlignment = textAlignment
            
            self.numberOfLines = 0
    }
    
    convenience init (
        x: CGFloat,
        y: CGFloat,
        width: CGFloat,
        attributedText: NSAttributedString,
        textAlignment: NSTextAlignment) {
            self.init(frame: CGRect (x: x, y: y, width: width, height: 10.0))
            self.attributedText = attributedText
            self.textAlignment = textAlignment
            
            self.numberOfLines = 0
            self.fitHeight()
    }
    
    convenience init (
        x: CGFloat,
        y: CGFloat,
        width: CGFloat,
        padding: CGFloat,
        attributedText: NSAttributedString,
        textAlignment: NSTextAlignment) {
            self.init(frame: CGRect (x: x, y: y, width: width, height: 10.0))
            self.attributedText = attributedText
            self.textAlignment = textAlignment
            
            self.numberOfLines = 0
            self.fitHeight()
            self.h += padding*2
    }
    
    convenience init (
        x: CGFloat,
        y: CGFloat,
        attributedText: NSAttributedString,
        textAlignment: NSTextAlignment) {
            self.init(frame: CGRect (x: x, y: y, width: 10.0, height: 10.0))
            self.attributedText = attributedText
            self.textAlignment = textAlignment
            
            self.numberOfLines = 0
            self.fitSize()
    }
    
}



// MARK: NSAttributedString

extension NSAttributedString {
    
    enum NSAttributedStringStyle {
        case plain
        case underline (NSUnderlineStyle, UIColor)
        case strike (UIColor, CGFloat)
        
        func attribute () -> [NSString: NSObject] {
            switch self {
                
            case .plain:
                return [:]
                
            case .underline(let styleName, let color):
                return [NSUnderlineStyleAttributeName: styleName.rawValue, NSUnderlineColorAttributeName: color]
                
            case .strike(let color, let width):
                return [NSStrikethroughColorAttributeName: color, NSStrikethroughStyleAttributeName: width]
            }
        }
    }
    
    func addAtt (attribute: [NSString: NSObject]) -> NSAttributedString {
        let mutable = NSMutableAttributedString (attributedString: self)
        let count = countElements(string)
        
        for (key, value) in attribute {
            mutable.addAttribute(key, value: value, range: NSMakeRange(0, count))
        }
        
        return mutable
    }
    
    func addStyle (style: NSAttributedStringStyle) -> NSAttributedString {
        return addAtt(style.attribute())
    }
    
    
    
    convenience init (
        text: String,
        color: UIColor,
        font: UIFont,
        style: NSAttributedStringStyle = .plain) {
            
            var atts = [NSFontAttributeName: font, NSForegroundColorAttributeName: color]
            atts += style.attribute()
            
            self.init (string: text, attributes: atts)
    }
    
    convenience init (image: UIImage) {
        let att = NSTextAttachment ()
        att.image = image
        self.init (attachment: att)
    }
    
    
    class func withAttributedStrings (mutableString: (NSMutableAttributedString)->()) -> NSAttributedString {
        var mutable = NSMutableAttributedString ()
        mutableString (mutable)
        return mutable
    }
}



// MARK: - String

extension String {
    subscript (i: Int) -> String {
        return String(Array(self)[i])
    }
}



// MARK: - UIFont

extension UIFont {
    
    enum FontType: String {
        case Regular = "Regular"
        case Bold = "Bold"
        case DemiBold = "DemiBold"
        case Light = "Light"
        case UltraLight = "UltraLight"
        case Italic = "Italic"
        case Thin = "Thin"
        case Book = "Book"
        case Roman = "Roman"
        case Medium = "Medium"
        case MediumItalic = "MediumItalic"
        case CondensedMedium = "CondensedMedium"
        case CondensedExtraBold = "CondensedExtraBold"
        case SemiBold = "SemiBold"
        case BoldItalic = "BoldItalic"
        case Heavy = "Heavy"
    }
    
    enum FontName: String {
        case HelveticaNeue = "HelveticaNeue"
        case Helvetica = "Helvetica"
        case Futura = "Futura"
        case Menlo = "Menlo"
        case Avenir = "Avenir"
        case AvenirNext = "AvenirNext"
        case Didot = "Didot"
        case AmericanTypewriter = "AmericanTypewriter"
        case Baskerville = "Baskerville"
        case Geneva = "Geneva"
        case GillSans = "GillSans"
        case SanFranciscoDisplay = "SanFranciscoDisplay"
        case Seravek = "Seravek"
    }
    
    class func PrintFontFamily (font: FontName) {
        let arr = UIFont.fontNamesForFamilyName(font.rawValue)
        for name in arr {
            println(name)
        }
    }
    
    class func Font (
        name: FontName,
        type: FontType,
        size: CGFloat) -> UIFont {
            return UIFont (name: name.rawValue + "-" + type.rawValue, size: size)!
    }
    
    class func HelveticaNeue (
        type: FontType,
        size: CGFloat) -> UIFont {
            return Font(.HelveticaNeue, type: type, size: size)
    }
    
    class func AvenirNext (
        type: FontType,
        size: CGFloat) -> UIFont {
        return UIFont.Font(UIFont.FontName.AvenirNext, type: type, size: size)
    }
    
    class func AvenirNextDemiBold (size: CGFloat) -> UIFont {
        return AvenirNext(UIFont.FontType.DemiBold, size: size)
    }
    
    class func AvenirNextRegular (size: CGFloat) -> UIFont {
        return AvenirNext(UIFont.FontType.Regular, size: size)
    }
}



// MARK: - UIImageView

extension UIImageView {
    
    convenience init (
        frame: CGRect,
        imageName: String) {
            self.init (frame: frame, image: UIImage (named: imageName)!)
    }
    
    convenience init (
        frame: CGRect,
        image: UIImage) {
            self.init (frame: frame)
            self.image = image
            self.contentMode = .ScaleAspectFit
    }
    
    convenience init (
        x: CGFloat,
        y: CGFloat,
        width: CGFloat,
        image: UIImage) {
            self.init (frame: CGRect (x: x, y: y, width: width, height: image.aspectHeightForWidth(width)), image: image)
    }
    
    convenience init (
        x: CGFloat,
        y: CGFloat,
        height: CGFloat,
        image: UIImage) {
            self.init (frame: CGRect (x: x, y: y, width: image.aspectWidthForHeight(height), height: height), image: image)
    }

    
    func imageWithUrl (url: String) {
        imageRequest(url, { (image) -> Void in
            if let img = image {
                self.image = image
            }
        })
    }
    
    func imageWithUrl (url: String, placeholder: UIImage) {
        self.image = placeholder
        imageRequest(url, { (image) -> Void in
            if let img = image {
                self.image = image
            }
        })
    }
    
    func imageWithUrl (url: String, placeholder: String) {
        self.image = UIImage (named: placeholder)
        imageRequest(url, { (image) -> Void in
            if let img = image {
                self.image = image
            }
        })
    }
}



// MARK: - UIImage

extension UIImage {
    
    func aspectResizeWithWidth (width: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: width, height: aspectHeightForWidth(width))
        
        UIGraphicsBeginImageContext(aspectSize)
        self.drawInRect(CGRect(origin: CGPointZero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
    }
    
    func aspectResizeWithHeight (height: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: aspectWidthForHeight(height), height: height)
        
        UIGraphicsBeginImageContext(aspectSize)
        self.drawInRect(CGRect(origin: CGPointZero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
    }
    
    
    func aspectHeightForWidth (width: CGFloat) -> CGFloat {
        return (width * self.size.height) / self.size.width
    }
    
    func aspectWidthForHeight (height: CGFloat) -> CGFloat {
        return (height * self.size.width) / self.size.height
    }
}



// MARK: - UIColor

extension UIColor {
    
    class func randomColor () -> UIColor {
        var randomRed:CGFloat = CGFloat(drand48())
        var randomGreen:CGFloat = CGFloat(drand48())
        var randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed,
            green: randomGreen,
            blue: randomBlue,
            alpha: 1.0)
    }
    
    class func RGBColor (
        r: CGFloat,
        g: CGFloat,
        b: CGFloat) -> UIColor {
            return UIColor (red: r / 255.0,
                green: g / 255.0,
                blue: b / 255.0,
                alpha: 1)
    }
    
    class func RGBAColor (
        r: CGFloat,
        g: CGFloat,
        b: CGFloat,
        a: CGFloat) -> UIColor {
            return UIColor (red: r / 255.0,
                green: g / 255.0,
                blue: b / 255.0,
                alpha: a)
    }
    
    class func BarTintRGBColor (
        r: CGFloat,
        g: CGFloat,
        b: CGFloat) -> UIColor {
            return UIColor (red: (r / 255.0) - 0.12,
                green: (g / 255.0) - 0.12,
                blue: (b / 255.0) - 0.12,
                alpha: 1)
    }
    
    class func Gray (gray: CGFloat) -> UIColor {
        return self.RGBColor(gray, g: gray, b: gray)
    }
    
    class func Gray (gray: CGFloat, alpha: CGFloat) -> UIColor {
        return self.RGBAColor(gray, g: gray, b: gray, a: alpha)
    }
    
    class func HexColor (hex: String) -> UIColor {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        var rgba = hex
        if !rgba.hasPrefix("#") {
            rgba = "#" + rgba
        }
        
        let index   = advance(rgba.startIndex, 1)
        let hex     = rgba.substringFromIndex(index)
        let scanner = NSScanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        
        if scanner.scanHexLongLong(&hexValue) {
            switch (countElements(hex)) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
            }
        } else {
            println("Scan hex error")
        }
        
        return UIColor (red: red, green:green, blue:blue, alpha:alpha)
    }
}



// MARK: - Array

extension Array {
    mutating func removeObject<U: Equatable> (object: U) {
        var index: Int?
        for (idx, objectToCompare) in enumerate(self) {
            if let to = objectToCompare as? U {
                if object == to {
                    index = idx
                }
            }
        }
        
        if(index != nil) {
            self.removeAtIndex(index!)
        }
    }
}



// MARK: - Dictionary

func += <KeyType, ValueType> (inout left: Dictionary<KeyType, ValueType>,
    right: Dictionary<KeyType, ValueType>) {
        for (k, v) in right {
            left.updateValue(v, forKey: k)
        }
}



// MARK: - Dispatch

func delay (
    seconds: Double,
    queue: dispatch_queue_t = dispatch_get_main_queue(),
    after: ()->()) {
        
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
        dispatch_after(time, queue, after)
}



// MARK: - DownloadTask

func urlRequest (
    url: String,
    success: (NSData?)->Void,
    error: ((NSError)->Void)? = nil) {
    NSURLConnection.sendAsynchronousRequest(
        NSURLRequest (URL: NSURL (string: url)!),
        queue: NSOperationQueue.mainQueue(),
        completionHandler: { response, data, err in
            if let e = err {
                error? (e)
            } else {
                success (data)
            }
    })
}

func imageRequest (
    url: String,
    success: (UIImage?)->Void) {
    
    urlRequest(url) {data in
        if let d = data {
            success (UIImage (data: d))
        }
    }
}

func jsonRequest (
    url: String,
    success: (AnyObject?->Void),
    error: ((NSError)->Void)?) {
    urlRequest(
        url,
        { (data)->Void in
            let json: AnyObject? = dataToJsonDict(data)
            success (json)
        },
        { (err)->Void in
            if let e = error {
                e (err)
            }
        })
}

func dataToJsonDict (data: NSData?) -> AnyObject? {

    if let d = data {
        var error: NSError?
        let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(
            d,
            options: NSJSONReadingOptions.AllowFragments,
            error: &error)
        
        if let e = error {
            return nil
        } else {
            return json
        }
    } else {
        return nil
    }
}



// MARK - UIScreen

var Orientation: UIInterfaceOrientation {
    get {
        return UIApplication.sharedApplication().statusBarOrientation
    }
}

var ScreenWidth: CGFloat {
    get {
        if UIInterfaceOrientationIsPortrait(Orientation) {
            return UIScreen.mainScreen().bounds.size.width
        } else {
            return UIScreen.mainScreen().bounds.size.height
        }
    }
}

var ScreenHeight: CGFloat {
    get {
        if UIInterfaceOrientationIsPortrait(Orientation) {
            return UIScreen.mainScreen().bounds.size.height
        } else {
            return UIScreen.mainScreen().bounds.size.width
        }
    }
}

var StatusBarHeight: CGFloat {
    get {
        return UIApplication.sharedApplication().statusBarFrame.height
    }
}



// MARK: - CGSize

func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize (width: left.width + right.width, height: left.height + right.height)
}

func - (left: CGSize, right: CGSize) -> CGSize {
    return CGSize (width: left.width - right.width, height: left.width - right.width)
}



// MARK: - CGPoint

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint (x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint (x: left.x - right.x, y: left.y - right.y)
}


enum AnchorPosition: CGPoint {
    case TopLeft        = "{0, 0}"
    case TopCenter      = "{0.5, 0}"
    case TopRight       = "{1, 0}"
    
    case MidLeft        = "{0, 0.5}"
    case MidCenter      = "{0.5, 0.5}"
    case MidRight       = "{1, 0.5}"
    
    case BottomLeft     = "{0, 1}"
    case BottomCenter   = "{0.5, 1}"
    case BottomRight    = "{1, 1}"
}

extension CGPoint: StringLiteralConvertible {
    
    public init(stringLiteral value: StringLiteralType) {
        self = CGPointFromString(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self = CGPointFromString(value)
    }
    
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self = CGPointFromString(value)
    }
}



// MARK: - CGFloat

func degreesToRadians (angle: CGFloat) -> CGFloat {
    return (CGFloat (M_PI) * angle) / 180.0
}


func normalizeValue (
    value: CGFloat,
    min: CGFloat,
    max: CGFloat) -> CGFloat {
        return (max - min) / value
}


func convertNormalizedValue (
    normalizedValue: CGFloat,
    min: CGFloat,
    max: CGFloat) -> CGFloat {
        return ((max - min) * normalizedValue) + min
}


func clamp (
    value: CGFloat,
    minimum: CGFloat,
    maximum: CGFloat) -> CGFloat {
    return min (maximum, max(value, minimum))
}



// MARK: - UIAlertController

func alert (
    title: String,
    message: String,
    cancelAction: ((UIAlertAction!)->Void)? = nil,
    okAction: ((UIAlertAction!)->Void)? = nil) -> UIAlertController {
        let a = UIAlertController (title: title, message: message, preferredStyle: .Alert)
        
        if let ok = okAction {
            a.addAction(UIAlertAction(title: "OK", style: .Default, handler: ok))
            a.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelAction))
        } else {
            a.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: cancelAction))
        }
        
        return a
}

func actionSheet (
    title: String,
    message: String,
    actions: [UIAlertAction]) -> UIAlertController {
        let a = UIAlertController (title: title, message: message, preferredStyle: .ActionSheet)
        
        for action in actions {
            a.addAction(action)
        }
        
        return a
}



// MARK: - UIBarButtonItem

func barButtonItem (
    imageName: String,
    size: CGFloat,
    action: (AnyObject)->()) -> UIBarButtonItem {
        let button = BlockButton (frame: CGRect(x: 0, y: 0, width: size, height: size))
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.actionBlock = action
        
        return UIBarButtonItem (customView: button)
}

func barButtonItem (
    imageName: String,
    action: (AnyObject)->()) -> UIBarButtonItem {
        return barButtonItem(imageName, 20, action)
}

func barButtonItem (
    title: String,
    color: UIColor,
    action: (AnyObject)->()) -> UIBarButtonItem {
        let button = BlockButton (frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(color, forState: .Normal)
        button.actionBlock = action
        button.sizeToFit()
        
        return UIBarButtonItem (customView: button)
}


// MARK: - Block Classes



// MARK: - BlockButton

class BlockButton: UIButton {
    
    init (x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        super.init (frame: CGRect (x: x, y: y, width: w, height: h))
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var actionBlock: ((sender: BlockButton) -> ())? {
        didSet {
            self.addTarget(self, action: "action:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func action (sender: BlockButton) {
        actionBlock! (sender: sender)
    }
}



// MARK: - BlockWebView

class BlockWebView: UIWebView, UIWebViewDelegate {
    
    var didStartLoad: ((NSURLRequest) -> ())?
    var didFinishLoad: ((NSURLRequest) -> ())?
    var didFailLoad: ((NSURLRequest, NSError) -> ())?
    
    var shouldStartLoadingRequest: ((NSURLRequest) -> (Bool))?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func webViewDidStartLoad(webView: UIWebView) {
        didStartLoad? (webView.request!)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        didFinishLoad? (webView.request!)
    }
    
    func webView(
        webView: UIWebView,
        didFailLoadWithError error: NSError) {
            didFailLoad? (webView.request!, error)
    }
    
    func webView(
        webView: UIWebView,
        shouldStartLoadWithRequest request: NSURLRequest,
        navigationType: UIWebViewNavigationType) -> Bool {
            if let should = shouldStartLoadingRequest {
                return should (request)
            } else {
                return true
            }
    }
}



// MARK: BlockTap

class BlockTap: UITapGestureRecognizer {
    
    private var tapAction: ((UITapGestureRecognizer)->())?
    
    override init(target: AnyObject, action: Selector) {
        super.init(target: target, action: action)
    }
    
    init (
        tapCount: Int,
        fingerCount: Int,
        action: ((UITapGestureRecognizer)->())?) {
            super.init()
            numberOfTapsRequired = tapCount
            numberOfTouchesRequired = fingerCount
            tapAction = action
            addTarget(self, action: "didTap:")
    }
    
    func didTap (tap: UITapGestureRecognizer) {
        tapAction? (tap)
    }
}



// MARK: BlockPan

class BlockPan: UIPanGestureRecognizer {
    
    private var panAction: ((UIPanGestureRecognizer)->())?
    
    override init(target: AnyObject, action: Selector) {
        super.init(target: target, action: action)
    }
    
    init (action: ((UIPanGestureRecognizer)->())?) {
        super.init()
        panAction = action
        addTarget(self, action: "didPan:")
    }
    
    func didPan (pan: UIPanGestureRecognizer) {
        panAction? (pan)
    }
}



// MARK: BlockSwipe

class BlockSwipe: UISwipeGestureRecognizer {
    
    private var swipeAction: ((UISwipeGestureRecognizer)->())?
    
    override init(target: AnyObject, action: Selector) {
        super.init(target: target, action: action)
    }
    
    init (direction: UISwipeGestureRecognizerDirection,
        fingerCount: Int,
        action: ((UISwipeGestureRecognizer)->())?) {
            super.init()
            self.direction = direction
            numberOfTouchesRequired = fingerCount
            swipeAction = action
            addTarget(self, action: "didSwipe:")
    }
    
    func didSwipe (swipe: UISwipeGestureRecognizer) {
        swipeAction? (swipe)
    }
}



// MARK: BlockPinch

class BlockPinch: UIPinchGestureRecognizer {
    
    private var pinchAction: ((UIPinchGestureRecognizer)->())?
    
    override init(target: AnyObject, action: Selector) {
        super.init(target: target, action: action)
    }
    
    init (action: ((UIPinchGestureRecognizer)->())?) {
        super.init()
        pinchAction = action
        addTarget(self, action: "didPinch:")
    }
    
    func didPinch (pinch: UIPinchGestureRecognizer) {
        pinchAction? (pinch)
    }
}



// MARK: BlockLongPress

class BlockLongPress: UILongPressGestureRecognizer {
    
    private var longPressAction: ((UILongPressGestureRecognizer)->())?
    
    override init(target: AnyObject, action: Selector) {
        super.init(target: target, action: action)
    }
    
    init (action: ((UILongPressGestureRecognizer)->())?) {
        super.init()
        longPressAction = action
        addTarget(self, action: "didLongPressed:")
    }
    
    func didLongPressed (longPress: UILongPressGestureRecognizer) {
        longPressAction? (longPress)
    }
}



// MARK: BlockBadge

class BlockBadge: UILabel {
    
    var attachedView: UIView!
    
    override var text: String? {
        didSet {
            sizeToFit()
            h = font.pointSize+5
            w += 10
            
            center = CGPoint (x: attachedView.right, y: attachedView.top)
        }
    }
    
    init (color: UIColor, font: UIFont) {
        super.init(frame: CGRect(x: 0, y: 0, width: font.pointSize+5, height: font.pointSize+5))
        
        self.backgroundColor = color
        self.font = font
        self.textAlignment = .Center
        setCornerRadius(h/2)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}



// MARK: BlockPicker

class BlockPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var items: [String]?
    var didPick: ((Int)->Void)?
    
    init (title: String, items: [String], didPick: (index: Int) -> Void) {
        super.init()
        self.items = items
        self.didPick = didPick
        
        self.delegate = self
        self.dataSource = self
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items!.count
    }
    
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didPick? (row)
    }
    
}



// MARK: DequeuableScrollView

class DequeuableScrollView: UIScrollView {
    
    private var reusableViews: [UIView] = []
    private var visibleRect: CGRect!
    
    
    override init (frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override var contentOffset: CGPoint{
        didSet {
            visibleRect = CGRect(origin: contentOffset, size: frame.size)
            updateReusableViews()
        }
    }
    
    override func addSubview(view: UIView) {
        super.addSubview(view)
        reusableViews.append(view)
        updateReusableViews()
    }
    
    func updateReusableViews () {
        for v in reusableViews {
            if CGRectIntersectsRect(v.frame, visibleRect) {
                if let s = v.superview {
                    if s == self {
                        continue
                    } else {
                        addSubview(v)
                    }
                } else {
                    addSubview(v)
                }
            } else {
                if let s = v.superview {
                    if s == self {
                        v.removeFromSuperview()
                    } else {
                        continue
                    }
                } else {
                    continue
                }
            }
        }
    }
}


