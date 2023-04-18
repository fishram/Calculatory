//
//  CalculatorViewModel.swift
//  Calculatory
//
//  Created by Fisher Ramsey on 4/18/23.
//

import Foundation
import SwiftUI
import Combine

class CalculatorViewModel: ObservableObject {
    @Published var currentInput: String = "0"
    @Published var previousInput: String = ""
    @Published var currentOperation: CalcButton? = nil

    func buttonTapped(_ item: CalcButton) {
        switch item {
        case .ac:
            currentInput = "0"
            previousInput = ""
            currentOperation = nil
        case .negative:
            if let currentValue = Double(currentInput) {
                currentInput = String(-currentValue)
            }
        case .percent:
            if let currentValue = Double(currentInput) {
                currentInput = String(currentValue / 100)
            }
        case .divide, .multiply, .minus, .plus:
            if currentOperation == nil {
                currentOperation = item
                previousInput = currentInput
                currentInput = "0"
            } else {
                performOperation()
                currentOperation = item
            }
        case .equals:
            performOperation()
            currentOperation = nil
        case .decimal:
            if !currentInput.contains(".") {
                currentInput += "."
            }
        default: // for numbers
            if currentInput == "0" {
                currentInput = item.rawValue
            } else {
                currentInput += item.rawValue
            }
        }
    }

    private func performOperation() {
        guard let operation = currentOperation,
              let previousValue = Double(previousInput),
              let currentValue = Double(currentInput) else {
            return
        }

        var result: Double?

        switch operation {
        case .plus:
            result = previousValue + currentValue
        case .minus:
            result = previousValue - currentValue
        case .multiply:
            result = previousValue * currentValue
        case .divide:
            if currentValue != 0 {
                result = previousValue / currentValue
            } else {
                currentInput = "Error" // handle division by zero
                return
            }
        default:
            break
        }

        if let finalResult = result {
            currentInput = String(finalResult)
            previousInput = ""
        }
    }
}
