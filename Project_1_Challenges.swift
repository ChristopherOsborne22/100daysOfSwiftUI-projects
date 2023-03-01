//
//  Project_1_Challenges.swift
//
//  Created by Dinh Huynh Chanh from 26/02/2023 to 27/02/2023.
//
//  This is a unit converter that has 3 types of conversion units: temperature, time, and distance.
//  The user can choose whichever they like and the UI is, for me, still quite raw but in the upcoming projects, it will look better :)

import SwiftUI

struct Project_1_Challenges: View {
    @State private var inputUnit = 0.0
    @State private var conversionType = "Temperature"
    @State private var selectedInputUnit = "°C"
    @State private var selectedOutputUnit = "°C"
    @FocusState private var amountIsFocused: Bool
    
    let conversionTypes = ["Temperature", "Time", "Distance"]
    
    var tableUnits: [String] {
        switch conversionType {
        case "Temperature":
            return ["°C", "°F", "K"]
        case "Time":
            return ["hour(s)", "minute(s)", "second(s)"]
        case "Distance":
            return ["kilometer(s)", "meter(s)", "centimeter(s)"]
        default:
            return ["Invalid"]
        }
    }
    
    var outputUnit: Double {
        if selectedInputUnit == selectedOutputUnit {
            return inputUnit
        } else {
            switch conversionType {
            case "Temperature":
                switch (selectedInputUnit, selectedOutputUnit) {
                case ("°C", "°F"):
                    return (inputUnit * 9/5) + 32.0
                case ("°C", "K"):
                    return inputUnit + 237.15
                case ("°F", "°C"):
                    return (inputUnit - 32.0) * (5/9)
                case ("°F", "°K"):
                    return (inputUnit - 32.0) * (5/9) + 237.15
                case ("°K", "°C"):
                    return inputUnit - 237.15
                case ("°K", "°F"):
                    return ((inputUnit - 237.15) * (9/5) + 32.0)
                    // kelvin conversion outputs negative number
                    // but I dont know what number format that allows this
                default:
                    return 0.0
                }
            case "Time":
                switch (selectedInputUnit, selectedOutputUnit) {
                case ("hour(s)", "minute(s)"):
                    return inputUnit * 60.0
                case ("hour(s)", "second(s)"):
                    return inputUnit * 60.0 * 60.0
                case ("minute(s)", "hour(s)"):
                    return inputUnit / 60.0
                case ("minute(s)", "second(s)"):
                    return inputUnit * 60.0
                case ("second(s)", "hour(s)"):
                    return inputUnit / (60.0 * 60.0)
                case ("second(s)", "minute(s)"):
                    return inputUnit / 60.0
                default:
                    return 0.0
                }
            case "Distance":
                switch (selectedInputUnit, selectedOutputUnit) {
                case ("kilometer(s)", "meter(s)"):
                    return inputUnit * 1000
                case ("kilometer(s)", "centimeter(s)"):
                    return inputUnit * 1000 * 100
                case ("meter(s)", "kilometer(s)"):
                    return inputUnit / 1000
                case ("meter(s)", "centimeter(s)"):
                    return inputUnit * 100
                case ("centimeter(s)", "kilometer(s)"):
                    return inputUnit / (100 * 1000)
                case ("centimeter(s)", "meter(s)"):
                    return inputUnit / 100
                default:
                    return 0.0
                }
            default:
                print("hello")
            }
        }
        return 0.0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Conversion type", selection: $conversionType) {
                        ForEach(conversionTypes, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Select conversion type")
                }
                
                Section {
                    TextField("Enter unit to convert", value: $inputUnit, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                } header: {
                    Text("Conversion Input")
                }
                
                Section {
                    Picker("Select the unit", selection: $selectedInputUnit) {
                        ForEach(tableUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select input unit")
                }
                
                Section {
                    Picker("Select the unit", selection: $selectedOutputUnit) {
                        ForEach(tableUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select output unit")
                }
                
                Section {
                    Text(outputUnit, format: .number)
                } header: {
                    Text("Conversion output")
                }
            
            }
            .navigationTitle("Convert Thee")
        }
    }
}

struct Project_1_Challenges_Previews: PreviewProvider {
    static var previews: some View {
        Project_1_Challenges()
    }
}
