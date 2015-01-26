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
        
        let firstItem = MaterialCardCell (card: c)
        firstItem.addText("First item")
        c.addCell(firstItem)
        
        let secondItem = MaterialCardCell (card: c)
        secondItem.addText("Second Item")
        c.addCell(secondItem)
        
        
        let header = MaterialCardCell (card: c)
        header.addTitle("Header Title")
        c.addHeaderCell(header)
        
        c.removeCell(firstItem)
    }

}

