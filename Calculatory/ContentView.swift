//
//  ContentView.swift
//  Calculatory
//
//  Created by Fisher Ramsey on 4/15/23.
//

import SwiftUI

// An enumeration representing the various calculator buttons
enum CalcButton: String {
    // Number buttons
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    
    // Function buttons
    case ac = "AC"
    case negative = "+/-"
    case percent = "%"
    case divide = "/"
    case multiply = "x"
    case minus = "-"
    case plus = "+"
    case equals = "="
    case decimal = "."
    case second = "2^nd"
        case square = "x^2"
        case cube = "x^3"
        case power = "x^y"
        case exp = "e^x"
        case tenPower = "10^x"
        case reciprocal = "1/x"
        case squareRoot = "√x"
        case cubeRoot = "∛x"
        case yRoot = "y√x"
        case ln = "ln"
        case log = "log₁₀"
        case factorial = "x!"
        case sin = "sin"
        case cos = "cos"
        case tan = "tan"
        case e = "e"
        case ee = "EE"
        case rad = "Rad"
        case sinh = "sinh"
        case cosh = "cosh"
        case tanh = "tanh"
        case pi = "π"
        case rand = "Rand"
    
    
    // Determines the button's color based on its type
    var buttonColor: Color {
        switch self {
        case .plus, .minus, .multiply, .divide, .equals:
            return .orange
        case .ac, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}


struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var buttonGrid: [[CalcButton]] {
            if horizontalSizeClass == .compact {
                return [
                    [.ac, .negative, .percent, .divide],
                    [.seven, .eight, .nine, .multiply],
                    [.four, .five, .six, .minus],
                    [.one, .two, .three, .plus],
                    [.zero, .decimal, .equals]
                ]
            } else {
                return [
                    [.second, .square, .cube, .power, .exp, .tenPower, .reciprocal, .ac, .negative, .percent, .divide],
                    [.squareRoot, .cubeRoot, .yRoot, .ln, .log, .factorial, .sin, .cos, .tan, .multiply, .minus],
                    [.e, .ee, .rad, .sinh, .cosh, .tanh, .seven, .eight, .nine, .plus],
                    [.pi, .rand, .four, .five, .six],
                    [.one, .two, .three],
                    [.zero, .decimal, .equals]
                ]
            }
        }
    @State private var tappedButton: CalcButton? = nil
    @StateObject private var viewModel = CalculatorViewModel()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(viewModel.currentInput)
                            .font(.system(size: 80))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .frame(minHeight: 100)
                    }
                    .padding(.top, geometry.safeAreaInsets.top + 20)
                    
                    ForEach(buttonGrid, id: \.self) { row in
                        HStack (spacing: 12){
                            ForEach(row, id: \.self) { item in
                                Button(action: {
                                    viewModel.buttonTapped(item)
                                }, label: {
                                    if item == .zero && horizontalSizeClass != .compact {
                                        Text(item.rawValue)
                                            .font(.system(size: 40))
                                            .frame(
                                                width: self.buttonWidth(geometry: geometry, item: item),
                                                height: self.buttonHeight(geometry: geometry)
                                            )
                                            .background(item.buttonColor)
                                            .foregroundColor(.white)
                                            .cornerRadius(self.buttonWidth(geometry: geometry, item: item)/2)
                                            .padding(.leading, 12)
                                    } else {
                                        Text(item.rawValue)
                                            .font(.system(size: 40))
                                            .frame(
                                                width: self.buttonWidth(geometry: geometry, item: item),
                                                height: self.buttonHeight(geometry: geometry)
                                            )
                                            .background(item.buttonColor)
                                            .foregroundColor(.white)
                                            .cornerRadius(self.buttonWidth(geometry: geometry, item: item)/2)
                                    }
                                })
                            }
                        }
                        .padding(.bottom, 3)
                    }
                }
                .padding()
            }
        }
    }


    
    func buttonWidth(geometry: GeometryProxy, item: CalcButton) -> CGFloat {
        let screenWidth = geometry.size.width
        let screenHeight = geometry.size.height
        let buttonSpace: CGFloat = 12
        
        let isLandscape = screenWidth > screenHeight
        let buttonCount: CGFloat = isLandscape ? 7 : 4
        
        if item == .zero && !isLandscape {
            return ((screenWidth - (buttonCount * buttonSpace)) / buttonCount) * 2
        }
        return (screenWidth - ((buttonCount + 1) * buttonSpace)) / buttonCount
    }

    func buttonHeight(geometry: GeometryProxy) -> CGFloat {
        let screenWidth = geometry.size.width
        let screenHeight = geometry.size.height
        let buttonSpace: CGFloat = 12
        
        let isLandscape = screenWidth > screenHeight
        let buttonCount: CGFloat = isLandscape ? 7 : 4
        let numberOfRows: CGFloat = isLandscape ? 5 : 4
        
        let totalSpacing = (numberOfRows + 1) * buttonSpace
        let availableHeight = min(screenWidth, screenHeight) - totalSpacing
        
        return availableHeight / numberOfRows
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
