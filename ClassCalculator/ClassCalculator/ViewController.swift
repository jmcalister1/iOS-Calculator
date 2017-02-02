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
    
    var CPU = CalculatorCPU()
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var info: UILabel!
    
    private var displayFormatter = NumberFormatter()
    
    var displayValue:Double {
        get {
            return Double(display.text!) ?? 0
        }
        set {
            displayFormatter.minimumIntegerDigits = 1
            displayFormatter.maximumFractionDigits = 10
            display.text = displayFormatter.string(from: NSNumber(value:newValue)) ?? "0"
        }
    }
    
    var infoValue:String {
        get {
            return String(info.text!) ?? " "
        }
        set {
            info.text = newValue
        }
        
    }
    
    func clearInfo() {
        CPU.description = " "
        infoValue = " "
    }
    
    @IBAction func digitPressed(_ sender: UIButton) {
        if let digit = sender.currentTitle {
            
            if userIsTyping {
                display.text! += digit
            } else {
                display.text = digit
                if !CPU.isPartialResult {
                    clearInfo()
                }
            }
            
            CPU.description += String(digit)
            
            userIsTyping = true
        }
    }
    
    @IBAction func touchDecimalPoint(_ sender: UIButton) {
        if let str = display.text {
            if userIsTyping {
                if !str.contains(".") {
                    display.text! += "."
                    CPU.description += "."
                }
            } else {
                display.text = "0."
                
                if !CPU.isPartialResult {
                    clearInfo()
                }
                
                CPU.description += "0."
            }
            
            userIsTyping = true
        }
    }
    
    @IBAction func doOperation(_ sender: UIButton) {
        if userIsTyping {
            CPU.setOperand(operand: displayValue)
            userIsTyping = false
        }
        
        let mathSymbol = sender.currentTitle
        
        if mathSymbol != nil {
            CPU.performOperation(symbol: mathSymbol!)
        }
        displayValue = CPU.result
        infoValue = CPU.description
        
        if mathSymbol! != "C"  {
            if CPU.isPartialResult {
                infoValue += " ..."
            } else {
                infoValue += " ="
            }
        }
    }
}

