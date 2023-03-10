//
//  WeSplit.swift
//
//  Created by Dinh Huynh Chanh from 11/2/2023 to 26/2/2023.
//
//  This is the original project made by Paul Hudson that helps user split check between the people they are with. 

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var peopleNumber = 2
    @State private var tipPercent = 0
    @FocusState private var amountIsFocused: Bool
    
    let tipPercents = [0, 10, 15, 20, 25] // for the user to choose tip amount
    
    var totalPriceWithTip: Double {
        let tipPercentage = Double(tipPercent)
        
        return (checkAmount + (checkAmount * tipPercentage / 100))
    }
    
    var totalPricePerPerson: Double {
        let peopleCount = Double(peopleNumber + 2)
        let grandTotalPerPerson = totalPriceWithTip
        / peopleCount
        
        return grandTotalPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check Amount", value: $checkAmount,
                              format:
                            .currency(code: Locale.current.currency?
                                .identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                } header: {
                    Text("Enter total price")
                }
                
                Section {
                    Picker("Tip percentages", selection: $tipPercent) {
                        ForEach(tipPercents, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                     Text("Select tip amount")
                }
                
                Section {
                    Text(totalPriceWithTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total price with tip")
                }
                
                Section {
                    Picker("Number of people", selection: $peopleNumber) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("Select number of people")
                }
                
                Section {
                    Text(totalPricePerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total price per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
