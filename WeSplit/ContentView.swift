//
//  ContentView.swift
//  WeSplit
//
//  Created by dan on 10/9/19.
//  Copyright © 2019 dan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @State private var checkAmount = ""
  @State private var numberOfPeople = ""
  @State private var tipPercentage = 2
  
  let tipPercentages = [0, 10, 15, 20, 25]
  
  var amountDue: (Double, Double) {
    let peopleCount = Double(numberOfPeople) ?? 1
    let tipSelection = Double(tipPercentages[tipPercentage])
    let orderAmount = Double(checkAmount) ?? 0
    
    let tipValue = orderAmount / 100 * tipSelection
    let grandTotal = orderAmount + tipValue
    let amountPerPerson = grandTotal > 0 ? grandTotal / peopleCount : 0
    
    return (grandTotal, amountPerPerson)
    
  }
  
  var body: some View {
    NavigationView {
      
      Form {
        Section {
          TextField("Amount", text: $checkAmount)
            .keyboardType(.numberPad)
          
          TextField("Number of People", text: $numberOfPeople)
            .keyboardType(.decimalPad)
          
          /*
           Picker("Number of people", selection: $numberOfPeople) {
           ForEach(2 ..< 100) {
           Text("\($0) people")
           }
           }
           */
        }
        
        Section(header: Text("How much tip do you want to leave?")) {
          Picker("Tip Percentage", selection: $tipPercentage) {
            ForEach(0 ..< tipPercentages.count) {
              Text("\(self.tipPercentages[$0])%")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
        
        Section(header: Text("Total amount (tip included)")) {
          Text("$\(amountDue.0, specifier: "%.2f")")
        }
        
        Section(header: Text("Amount per person")) {
          Text("$\(amountDue.1, specifier: "%.2f")")
        }
        
      }
      .navigationBarTitle("WeSplit")
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
