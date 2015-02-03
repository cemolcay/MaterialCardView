//
//  ViewController.swift
//  MaterialCardView
//
//  Created by Cem Olcay on 22/01/15.
//  Copyright (c) 2015 Cem Olcay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var v: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let c = MaterialCardView (x: 10, y: StatusBarHeight + 10, w: ScreenWidth-20)
        view.addSubview(c)
        
        c.addHeader("Header")
        c.addCell("Item 1")
        c.addCell("Item 2")
        c.addCell("Item 3")
        
        let container = UIView (x: 0, y: 0, w: c.w, h: 0)
        
        let label = UILabel (
            x: 10,
            y: 0,
            width: c.w - 10,
            padding: 10,
            attributedText: NSAttributedString.withAttributedStrings({ (att: NSMutableAttributedString) -> () in
                att.appendAttributedString(NSAttributedString (
                    text: "Att ",
                    color: UIColor.brownColor(),
                    font: UIFont.AvenirNextRegular(15),
                    style: .plain))
                att.appendAttributedString(NSAttributedString (
                    text: "\nTest",
                    color: UIColor.blueColor(),
                    font: UIFont.AvenirNextDemiBold(15),
                    style: .plain))
                att.appendAttributedString(NSAttributedString (
                    text: "\npowered by CEMKit",
                    color: UIColor.redColor(),
                    font: UIFont.AvenirNextRegular(13),
                    style: .underline(NSUnderlineStyle.StyleSingle, UIColor.blackColor())))
            }),
            textAlignment: .Center)
        
        container.addSubview(label)
        container.h = label.h
        
        let v = UIView (x: 20, y: 20, w: 20, h: 20)
        v.backgroundColor = UIColor.randomColor()
        v.materialize()
        container.addSubview(v)
        
        container.addTapGesture(1) { sender in
            v.backgroundColor = UIColor.randomColor()
        }
        
        container.addRipple(UIColor.RGBAColor(51, g: 51, b: 51, a: 0.2), duration: 0.5, location: .TouchLocation)
        
        c.addFooter(container)
    }
}

