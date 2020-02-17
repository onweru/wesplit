//
//  ContentView.swift
//  WeSplit
//
//  Created by dan on 10/9/19.
//  Copyright © 2019 dan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var amountBilled: String = ""
    @State private var numberOfPeople: String =  ""
    @State private var tipPercentage = 2
    
    let tipPercentages: [Double] = [5 ,10, 15, 20, 25]
    
    var totalAmount: (Double, Double) {
        let amount = Double(amountBilled) ?? 0
        let persons = Double(numberOfPeople) ?? 2
        let tip = amount * tipPercentages[tipPercentage] / 100
        let amountPerPerson = amount / persons
        let totalAmountPerPerson = amountPerPerson + tip / persons
        return (amountPerPerson, totalAmountPerPerson)
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Amount Billed Per Person")){
                    TextField("Amount", text: $amountBilled).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Number of People")) {
                    TextField("# of people", text: $numberOfPeople).keyboardType(.numberPad)
                }
                
                Section(header: Text("Tip Percentage")) {
                    Picker("% Tip", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0], specifier: "%.0f")%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total Amount to pay")) {
                    Text("\(totalAmount.0, specifier: "%.2f")")
                }
                
                Section(header: Text("Total Amount per person + tip")) {
                    Text("\(totalAmount.1, specifier: "%.2f")")
                }
                  
            }
            
            .navigationBarTitle("We Split")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
