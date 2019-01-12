//
//  ViewController.swift
//  Calculator
//
//  Created by Andrea Christie on 1/10/19.
//  Copyright © 2019 Andrea Christie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var screenLabel: UILabel!
    
    @IBOutlet var numbersButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!
    
    var previousButtonPressedText = ""
    var numbersToCalculate: [Double] = []
    var currentNumString = ""
    var requestedMathOps: [String] = []
    let mathOperators = ["/","x","-","+"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        
        if previousButtonPressedText == "=" {
            currentNumString = ""
        }
        
        let numText = sender.currentTitle!
        currentNumString += numText
        previousButtonPressedText = numText
        screenLabel.text = currentNumString
    }
    
    @IBAction func operatorPressed(_ sender: UIButton) {

        let mathOp = sender.currentTitle!
        
        if mathOperators.contains(previousButtonPressedText) {
            requestedMathOps.remove(at: (requestedMathOps.count - 1))
        }
        
        requestedMathOps.append(mathOp)
    
        if let number = Double(currentNumString) {
            numbersToCalculate.append(number)
            print(number)
            currentNumString = ""
            previousButtonPressedText = mathOp
        }
    }

    @IBAction func equalPressed(_ sender: UIButton) {
        
        let result = calculate()
        
        // check to see if the result is a whole number and if so, print as Int (instead of Double)
        if result == Double(Int(result)){
            screenLabel.text = String(Int(result))
        } else {
            screenLabel.text = String(result)
        }
        previousButtonPressedText = "="
        currentNumString = "\(result)"
        numbersToCalculate = []
        requestedMathOps = []
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        clearCalculator()
    }
    
    @IBAction func posNegPressed(_ sender: UIButton) {
        
        if mathOperators.contains(previousButtonPressedText) {
            clearCalculator()
        }
        changeSign()
    }
    @IBAction func percentagePressed(_ sender: UIButton) {
        if let number = Double(currentNumString) {
            let dividedBy100 = number / 100
            currentNumString = "\(dividedBy100)"
            screenLabel.text = currentNumString
        }
    }
    
    func clearCalculator() {
        previousButtonPressedText = ""
        numbersToCalculate = []
        currentNumString = ""
        requestedMathOps = []
        screenLabel.text = "0"
    }
    
    func changeSign() {
        if let number = Double(currentNumString) {
            
            let opposite = number * -1
            print(opposite)
            
            currentNumString = "\(opposite)"
            
            if opposite == Double(Int(opposite)) {
                screenLabel.text = String(Int(opposite))
            } else {
                screenLabel.text = currentNumString
            }
        }
    }
    
    func calculate() -> Double {
        
        if let number = Double(currentNumString) {
            numbersToCalculate.append(number)
            print(number)
        }
        
        var result = numbersToCalculate[0]
        
        for index in (1...numbersToCalculate.count - 1) {
            
            switch requestedMathOps[index-1] {
            case "/": result /= numbersToCalculate[index]
            case "x": result *= numbersToCalculate[index]
            case "-": result -= numbersToCalculate[index]
            case "+": result += numbersToCalculate[index]
            default: result += 0
            }
        }
        return result
    }
}
