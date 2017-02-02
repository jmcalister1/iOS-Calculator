//
//  CalculatorCPU.swift
//  ClassCalculator
//
//  Created by Joshua McAlister on 1/24/17.
//  Copyright © 2017 Harding University. All rights reserved.
//

import Foundation

func divide(op1:Double, op2:Double) -> Double {
    return op1 / op2
}

func multiply(op1:Double, op2:Double) -> Double {
    return op1 * op2
}

func subtract(op1:Double, op2:Double) -> Double {
    return op1 - op2
}

func add(op1:Double, op2:Double) -> Double {
    return op1 + op2
}

class CalculatorCPU {
    
    private var accumulator:Double = 0.0
    
    var description:String = " "
    
    struct PendingBinaryOperation {
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
    }
    private var pending: PendingBinaryOperation?
    
    var isPartialResult: Bool {
        get {
            return pending != nil
        }
    }
    
    func setOperand(operand:Double) {
        accumulator = operand
    }
    
    func performOperation(symbol:String) {
        switch symbol {
        case "C":
            accumulator = 0.0
            description = " "
            pending = nil
        case "±": accumulator *= -1.0
        case "%": accumulator /= 100.0
        case "÷":
            description += " ÷ "
            performEquals()
            pending = PendingBinaryOperation(binaryFunction:divide, firstOperand: accumulator)
        case "×":
            description += " × "
            performEquals()
            pending = PendingBinaryOperation(binaryFunction:multiply, firstOperand: accumulator)
        case "-":
            description += " - "
            performEquals()
            pending = PendingBinaryOperation(binaryFunction:subtract, firstOperand: accumulator)
        case "+":
            description += " + "
            performEquals()
            pending = PendingBinaryOperation(binaryFunction:add, firstOperand: accumulator)
        case "=":
            performEquals()
        case "sin":
            description = "sin(" + description + ")"
            performEquals()
            accumulator = sin(accumulator)
        case "cos":
            description = "cos(" + description + ")"
            performEquals()
            accumulator = cos(accumulator)
        case "tan":
            description = "tan(" + description + ")"
            performEquals()
            accumulator = tan(accumulator)
        case "√":
            description = "√(" + description + ")"
            performEquals()
            accumulator = sqrt(accumulator)
        case "x²":
            description = "(" + description + ")²"
            performEquals()
            accumulator = pow(accumulator, 2)
        case "π":
            accumulator = M_PI
        default: break
        }
    }
    
    private func performEquals() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    var result:Double {
        get {
            return accumulator
        }
    }
    
    
}
