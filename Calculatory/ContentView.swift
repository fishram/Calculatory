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
    @State private var tappedButton: CalcButton? = nil
    
    // A 2D array representing the layout of the calculator buttons
    let buttonGrid: [[CalcButton]] = [
        [.ac, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        ZStack {
            // Set the background color to black
            Color.black.ignoresSafeArea()
            
            VStack {
                // Display the current input/result
                Spacer()
                HStack {

                    Spacer()
                    Text("0")
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                }
                .padding(.top, 10)
                
                // Loop through the button grid and create the buttons
                ForEach(buttonGrid, id: \.self) { row in
                            HStack (spacing: 12){
                                ForEach(row, id: \.self) { item in
                                    Button(action: {
                                        tappedButton = item
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            tappedButton = nil
                                        }
                                        // Button action here
                                    }, label: {
                                        ZStack(alignment: item == .zero ? .leading : .center) {
                                            RoundedRectangle(cornerRadius: self.buttonWidth(item: item)/2)
                                                .fill(item.buttonColor)
                                            
                                            Text(item.rawValue)
                                                .font(.system(size: 40))
                                                .padding(item == .zero ? EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0) : EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                            
                                            if tappedButton == item {
                                                RoundedRectangle(cornerRadius: self.buttonWidth(item: item)/2)
                                                    .fill(Color.white.opacity(0.2))
                                            }
                                        }
                                    })
                                    .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                    .foregroundColor(.white)
                                    .animation(.easeInOut(duration: 0.1), value: tappedButton == item)
                                }
                            }
                            .padding(.bottom, 3 )
                        }
            }
            .padding()
        }
    }
    
    // Calculate the button width depeding on if it's a zero or not
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero{
            return ((UIScreen.main.bounds.width - (3*12))/4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    // Calculate the button height
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
