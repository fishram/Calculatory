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
    case squareRoot = "√"
    case square = "x²"
    case cube = "x³"
    case power = "x^y"
    case sin = "sin"
    case cos = "cos"
    case tan = "tan"
    case sinh = "sinh"
    case cosh = "cosh"
    case tanh = "tanh"
    case e = "e"
    case ln = "ln"
    case log = "log₁₀"
    case factorial = "x!"
    case pi = "π"
    
    
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
                    [.ac, .negative, .percent, .divide, .sin, .cos, .tan],
                    [.seven, .eight, .nine, .multiply, .sinh, .cosh, .tanh],
                    [.four, .five, .six, .minus, .e, .pi, .squareRoot],
                    [.one, .two, .three, .plus, .power, .log, .ln],
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
                    HStack {
                        Spacer()
                        Text(viewModel.currentInput)
                            .font(.system(size: 80))
                            .foregroundColor(.white)
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
