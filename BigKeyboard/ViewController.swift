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
    let ALPHABET :NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
    
    func lineWrap(title: String) -> String {
        var j = 0
        var titleBuffer = ""
        for c in (title.characters) {
            titleBuffer = titleBuffer + String(c)
            if j == 2 {
                titleBuffer = titleBuffer + "\n"
                j = 0
            } else {
                j = j + 1
            }
        }

        return titleBuffer.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    func setupButtons() {
        var i = 0

        for b in BUTTONS! {
    
            b.titleLabel?.textAlignment = .Center;
            b.titleLabel?.numberOfLines = 0
            
            let title = ALPHABET.substringWithRange(NSRange(location: i, length: 5))
            b.setTitle(lineWrap(title), forState: .Normal)
            i = i + 5
        }
        
        //when button 4 is inside the loop with a hard coded fix to add z, it kept adding z every time back was pressed.
        BUTTONS![4].setTitle(lineWrap(ALPHABET.substringWithRange(NSRange(location: 20, length: 6))), forState: .Normal)
        ZButton.setTitle("SPACE", forState: .Normal)
        ZButton.hidden = false
        ZButton.titleLabel?.textAlignment = .Center;
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
        

        
        let letters = x.titleLabel?.text!.stringByReplacingOccurrencesOfString("\n", withString: "")
        var i = 0
        for c in (letters?.characters)! {
            BUTTONS![i].setTitle( "\(c)", forState: .Normal)
            i = i + 1
            if i == BUTTONS?.count {
                break
            }
        }
        
        if (x == BUTTONS![4]) {
            ZButton.hidden = false
            ZButton.setTitle("Z", forState: .Normal)
        } else {
            ZButton.hidden = true
        }
        BackButton.hidden = false
        
        
    }
    
    
    
}

