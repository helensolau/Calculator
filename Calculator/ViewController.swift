//
//  ViewController.swift
//  Calculator
//
//  Created by Helen Lau on 6/28/16.
//  Copyright © 2016 Helen Lau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UITextField!

    var userIsInTheMiddleOfTyping = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if (userIsInTheMiddleOfTyping) {
            display.text = display.text!.componentsSeparatedByString(".").count <= 1 || digit != "." ? display.text! + digit : display.text!
        } else {
            display.text = digit
            userIsInTheMiddleOfTyping = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                display.text = "bad entery"
            }
        }
    }

    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        if display.text == "." {
            display.text = "bad entery"
        } else if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            display.text = "bad entery"
        }
    }
    
    @IBAction func clear() {
        userIsInTheMiddleOfTyping = false
        display.text = "0"
        brain.clear()
    }
    
    var displayValue: Double! {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTyping = false
        }
    }
}

