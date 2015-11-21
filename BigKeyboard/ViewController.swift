//
//  ViewController.swift
//  BigKeyboard
//
//  Created by Zarakas, James on 11/20/15.
//  Copyright © 2015 Zarakas, James. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Buffer: UILabel!
    
    @IBOutlet weak var ZButton: UIButton!
    @IBOutlet var BUTTONS: Array<UIButton>?
    
    @IBOutlet weak var BackButton: UIButton!
    let ALPHABET :NSString = "ABC\nDEFGHIJKLMNOPQRSTUVWXYZ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    func setupButtons() {
        var i = 0
        for b in BUTTONS! {
            b.contentHorizontalAlignment = .Center
            b.contentVerticalAlignment = .Center
            b.titleLabel?.numberOfLines = 0
            b.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            b.setTitle(ALPHABET.substringWithRange(NSRange(location: i, length: 5)), forState: .Normal)
            i = i + 5
        }
        //when button 4 is inside the loop with a hard coded fix to add z, it kept adding z every time back was pressed.
        BUTTONS![4].setTitle(ALPHABET.substringWithRange(NSRange(location: 20, length: 6)), forState: .Normal)
        ZButton.setTitle("SPACE", forState: .Normal)
        BackButton.hidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClear(sender: AnyObject) {
        Buffer.text = ""
    }
    
    @IBAction func onZ(sender: AnyObject) {
        let x: UIButton = sender as! UIButton
        if x.titleLabel!.text == "Z" {
            Buffer.text = Buffer.text! + "Z"
            setupButtons()
            return
        }
        
        Buffer.text = Buffer.text! + " "
    }
    @IBAction func onBackspace(sender: AnyObject) {
        let words :NSString = Buffer.text!
        if words.length == 0 {
            return
        }
        Buffer.text = words.substringToIndex(words.length-1)
    }
    
    @IBAction func onBack(sender: AnyObject) {
        setupButtons()
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
        
        let x: UIButton = sender as! UIButton
        
        if (x.titleLabel!.text!.characters.count == 1) {
            Buffer.text = Buffer.text! + x.titleLabel!.text!
            setupButtons()
            return
        }
        
        let letters = x.titleLabel?.text
        var i = 0
        for c in (letters?.characters)! {
            BUTTONS![i].setTitle( "\(c)", forState: .Normal)
            i = i + 1
            if i == BUTTONS?.count {
                break
            }
        }
        ZButton.setTitle("Z", forState: .Normal)
        BackButton.hidden = false
        
        
    }
    
    
    
}

