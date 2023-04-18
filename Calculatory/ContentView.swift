//
//  ContentView.swift
//  Calculatory
//
//  Created by Fisher Ramsey on 4/15/23.
//

import SwiftUI

enum CalcButton: String {
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
    case ac = "AC"
    case negative = "+/-"
    case percent = "%"
    case divide = "/"
    case multiply = "x"
    case minus = "-"
    case plus = "+"
    case equals = "="
    case decimal = "."
    
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
    
    let buttonGrid: [[CalcButton]] = [
        [.ac, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
               
                HStack {
                    Spacer()
                    Text("0")
                        .font(.system(size: 80))
                    .foregroundColor(.white)
                }
                ForEach(buttonGrid, id: \.self) { row in
                    HStack (spacing: 12){
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 40))
                                    .frame(
                                        width: self.buttonWidth(item: item), height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                                    
                            })
                        }
                    }
                    .padding(.bottom, 3 )
                }
                
            }
            .padding()
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero{
            return ((UIScreen.main.bounds.width - (3*12))/4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
