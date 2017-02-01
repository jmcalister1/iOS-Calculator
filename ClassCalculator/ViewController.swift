//
//  ViewController.swift
//  ClassCalculator
//
//  Created by Joshua McAlister on 1/24/17.
//  Copyright © 2017 Harding University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userIsTyping = false

    @IBOutlet weak var display: UILabel!
    
    var displayValue:Double {
        get {
            return Double(display.text!) ?? 0.0
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func digitPressed(_ sender: UIButton) {
        if let digit = sender.currentTitle {
            if userIsTyping {
                display.text! += digit
            } else {
                display.text = digit
            }
            userIsTyping = true
        }
    }
    
    @IBAction func touchDecimalPoint(_ sender: UIButton) {
        if let str = display.text {
            if userIsTyping {
                if !str.contains(".") {
                    display.text! += "."
                }
            } else {
                display.text = "0."
            }
            userIsTyping = true
        }
    }
    
    var CPU = CalculatorCPU()
    
    @IBAction func doOperation(_ sender: UIButton) {
        if userIsTyping {
            CPU.setOperand(operand: displayValue)
            userIsTyping = false
        }
        if let mathSymbol = sender.currentTitle {
            CPU.performOperation(symbol: mathSymbol)
        }
        displayValue = CPU.result
    }
}

