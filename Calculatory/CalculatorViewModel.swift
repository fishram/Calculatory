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
    @Published var previousInput: String = "0"
    @Published var currentOperation: CalcButton? = nil
    private var firstValue: Double?
    private var operation: CalcButton?
    @Published var currentInput: String = "0"
    private var result: Double? {
            didSet {
                guard let result = result else { return }
                currentInput = String(result)
            }
        }
    private var storedValue: Double?
    var formattedInput: String {
        if currentInput.isEmpty {
            if let result = result {
                let isInteger = floor(result) == result
                return isInteger ? String(format: "%.0f", result) : String(result)
            } else {
                return "0"
            }
        } else {
            return currentInput
        }
    }

    func buttonTapped(_ item: CalcButton) {
        switch item {
        case .ac:
            currentInput = "0"
            
        case .negative:
            if let currentValue = Double(currentInput) {
                currentInput = String(currentValue * -1)
            }
            
        case .percent:
            if let currentValue = Double(currentInput) {
                currentInput = String(currentValue / 100)
            }
            
        case .divide, .multiply, .minus, .plus, .power:
            if let currentValue = Double(currentInput) {
                firstValue = currentValue
                operation = item
                currentInput = ""
            }
            
        case .equals:
            if let currentValue = Double(currentInput),
               let firstValue = firstValue,
               let operation = operation {
                switch operation {
                case .plus:
                    currentInput = String(firstValue + currentValue)
                    
                case .minus:
                    currentInput = String(firstValue - currentValue)
                    
                case .multiply:
                    currentInput = String(firstValue * currentValue)
                    
                case .divide:
                    currentInput = String(firstValue / currentValue)
                    
                case .power:
                    currentInput = String(pow(firstValue, currentValue))
                    
                default:
                    break
                }
                self.firstValue = nil
                self.operation = nil
            }
            
        case .decimal:
            if !currentInput.contains(".") {
                currentInput += "."
            }
            
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            if currentInput == "0" {
                currentInput = item.rawValue
            } else {
                currentInput += item.rawValue
            }
            
        case .sin, .cos, .tan, .sinh, .cosh, .tanh, .e, .pi, .squareRoot, .log, .ln:
            if let currentValue = Double(currentInput) {
                switch item {
                case .sin:
                    currentInput = String(sin(currentValue))
                    
                case .cos:
                    currentInput = String(cos(currentValue))
                    
                case .tan:
                    currentInput = String(tan(currentValue))
                    
                case .sinh:
                    currentInput = String(sinh(currentValue))
                    
                case .cosh:
                    currentInput = String(cosh(currentValue))
                    
                case .tanh:
                    currentInput = String(tanh(currentValue))
                    
                case .e:
                    currentInput = String(exp(currentValue))
                    
                case .pi:
                    currentInput = String(currentValue * Double.pi)
                    
                case .squareRoot:
                    currentInput = String(sqrt(currentValue))
                    
                case .log:
                    currentInput = String(log10(currentValue))
                    
                case .ln:
                    currentInput = String(log(currentValue))
                    
                default:
                    break
                }
            }
            
        default:
            break
        }
    }
    func factorial(_ n: Int) -> Int {
            return (n == 0) ? 1 : n * factorial(n - 1)
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
