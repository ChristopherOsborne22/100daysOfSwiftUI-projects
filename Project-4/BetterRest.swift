//
//  ContentView.swift
//  BetterRest
//
//  Created by Dinh Huynh Chanh from 18/03/2023 to 19/03/2023
//

import CoreML
import SwiftUI
// Always sort imported frameworks alphabetically

struct ContentView: View {
    @State private var wakeUpTime = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeCups = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    static var defaultWakeUpTime: Date {
        // A Date value type
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }   // Static properties don't reference a specific instance
        // So, you can reference static properties inside initializers for regular properties.
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    GeometryReader { geometry in
                        DatePicker("Select a date", selection: $wakeUpTime, in: wakeUpTime..., displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        // No end date means that the time goes to infinity
                    }
                    // This is new and it helps align the button in Form View to be in the middle. Using frame and alignment won't help.
                } header: {
                    Text("Wake up time")
                        .font(.headline)
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired hours of sleep")
                        .font(.headline)
                }
                
                Section {
                    Picker("Coffee Cups", selection: $coffeCups) {
                        ForEach(1..<21) { num in
                            Text(num == 1 ? "1 cup" : "\(num) cups")
                        }
                    }
                } header: {
                    Text("Amount Of Coffee Cups Taken")
                        .font(.headline)
                }
                
                GeometryReader { geometry in
                    Button("Calculate", action: calculateBedTime)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                }
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calculate", action: calculateBedTime)
//            }
            // >> I decided to use a button at the bottom of the View instead of the top right button used by Mr. Hudson
            .alert(alertTitle, isPresented: $showAlert) {
                Button("Thank you!") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedTime() {
        // Use DO CATCH block, because error loading the model can occur or error predicting from our given variables
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            // reads all the features we listed while training the model
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hourInSeconds = (components.hour ?? 0) * 60 * 60
            let minuteInSeconds = (components.minute ?? 0) * 60
            // converts all time values into seconds
            
            let prediction = try model.prediction(wake: Double(hourInSeconds + minuteInSeconds), estimatedSleep: sleepAmount, coffee: Double(coffeCups))
            
            let sleepTime = wakeUpTime - prediction.actualSleep
            // the time of wake up minus the hours of sleep with all the above variables
            alertTitle = "Your bedtime should be..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error!"
            alertMessage = "We're sorry to inform that there has been an unexpected error."
        }
        
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
