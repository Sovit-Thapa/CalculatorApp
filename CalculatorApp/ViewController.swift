//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Sovit Thapa on 2024-09-01.
//

import UIKit

class ViewController: UIViewController {

    // Outlets for UILabels that display workings and results
    @IBOutlet var calculatorWorkings: UILabel!
    @IBOutlet var calculatorResults: UILabel!
    
    // Variables to keep track of the current workings and result
    var workings: String = ""
    var result: Double = 0.0
    var hasResult: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
    }
    
    // Clears all text from workings and results, and resets state
    func clearAll() {
        workings = ""
        calculatorWorkings.text = ""
        calculatorResults.text = ""
        hasResult = false
    }
    
    // Handles the equal button tap to calculate and display the result
    @IBAction func equalsTap(_ sender: Any) {
        if validInput() {
            // Replace percentage with equivalent decimal in expression
            let checkWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: checkWorkingsForPercent)
            if let resultValue = expression.expressionValue(with: nil, context: nil) as? Double {
                result = resultValue
                let resultString = formatResult(result: result)
                calculatorResults.text = resultString
                hasResult = true
            }
        } else {
            // Show alert if the input is invalid
            let alert = UIAlertController(title: "Invalid Input", message: "Calculator Cannot Do That.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Handles the percent button tap
    @IBAction func percentTap(_ sender: Any) {
        clearResultLabel()  // Clear the results label before appending "%"
        addToWorkings(value: "%")
        calculateAndDisplayResult()
    }
    
    // Handles the divide button tap
    @IBAction func divideTap(_ sender: Any) {
        appendOperationToWorkings(operation: "/")
    }
    
    // Handles the multiply button tap
    @IBAction func multiplyTap(_ sender: Any) {
        appendOperationToWorkings(operation: "*")
    }
    
    // Handles the minus button tap
    @IBAction func minusTap(_ sender: Any) {
        appendOperationToWorkings(operation: "-")
    }
    
    // Handles the plus button tap
    @IBAction func plusTap(_ sender: Any) {
        appendOperationToWorkings(operation: "+")
    }
    
    // Appends the selected operation to the workings string
    func appendOperationToWorkings(operation: String) {
        if hasResult {
            workings = formatResult(result: result) + " " + operation + " "
            hasResult = false
        } else {
            workings += " " + operation + " "
        }
        calculatorWorkings.text = workings
        clearResultLabel()
    }
    
    // Calculates the result and updates the result label
    func calculateAndDisplayResult() {
        if validInput() {
            let checkWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: checkWorkingsForPercent)
            if let resultValue = expression.expressionValue(with: nil, context: nil) as? Double {
                result = resultValue
                let resultString = formatResult(result: result)
                calculatorResults.text = resultString
                hasResult = true
            }
        } else {
            // Show alert if the input is invalid
            let alert = UIAlertController(title: "Invalid Input", message: "Calculator Cannot Do That.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // Clears the result label
    func clearResultLabel() {
        calculatorResults.text = ""
    }
    
    // Validates the input to ensure it's correctly formatted
    func validInput() -> Bool {
        var count = 0
        var funcCharIndexes = [Int]()
        
        for char in workings {
            if specialCharacter(char: char) {
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        var previous: Int = -1
        
        for index in funcCharIndexes {
            if index == 0 {
                return false
            }
            if index == workings.count - 1 {
                return false
            }
            if previous != -1 {
                if index - previous == 1 {
                    return false
                }
            }
            previous = index
        }
        
        return true
    }
    
    // Checks if a character is a special operator
    func specialCharacter(char: Character) -> Bool {
        return char == "*" || char == "/" || char == "+" || char == "-"
    }
    
    // Formats the result to display without unnecessary decimal places
    func formatResult(result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
    
    // Handles the all clear button tap
    @IBAction func allClearTap(_ sender: Any) {
        clearAll()
    }
    
    // Handles the backspace button tap
    @IBAction func backTap(_ sender: Any) {
        if !calculatorResults.text!.isEmpty {
            // Clear all if there is text in the result label
            clearAll()
        } else if !workings.isEmpty {
            // Remove last character if there is text only in workings
            workings.removeLast()
            calculatorWorkings.text = workings
        }
    }
    
    // Adds a value to the workings string
    func addToWorkings(value: String) {
        // If there's text in the result label, clear all labels and start a new calculation
        if !calculatorResults.text!.isEmpty {
            clearAll()
        }
        workings += value
        calculatorWorkings.text = workings
    }
    
    // Handles digit button taps
    @IBAction func decimalTap(_ sender: Any) {
        addToWorkings(value: ".")
    }
    
    @IBAction func zeroTap(_ sender: Any) {
        addToWorkings(value: "0")
    }
    
    @IBAction func oneTap(_ sender: Any) {
        addToWorkings(value: "1")
    }
    
    @IBAction func twoTap(_ sender: Any) {
        addToWorkings(value: "2")
    }
    
    @IBAction func threeTap(_ sender: Any) {
        addToWorkings(value: "3")
    }
    
    @IBAction func fourTap(_ sender: Any) {
        addToWorkings(value: "4")
    }
    
    @IBAction func fiveTap(_ sender: Any) {
        addToWorkings(value: "5")
    }
    
    @IBAction func sixTap(_ sender: Any) {
        addToWorkings(value: "6")
    }
    
    @IBAction func sevenTap(_ sender: Any) {
        addToWorkings(value: "7")
    }
    
    @IBAction func eightTap(_ sender: Any) {
        addToWorkings(value: "8")
    }
    
    @IBAction func nineTap(_ sender: Any) {
        addToWorkings(value: "9")
    }
}
