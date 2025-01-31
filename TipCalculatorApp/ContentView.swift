//
//  ContentView.swift
//  TipCalculatorApp
//
//  Created by Ummadipolu Lakshmi Tulasi on 1/31/25.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount: Double = 50.0
    @State private var tipPercentage: Double = 15.0
    @State private var numberOfPeople: Double = 1
    @State private var showResults: Bool = false
    @State private var selectedCurrency: String = "USD"

    let currencyOptions = ["USD", "EUR", "GBP", "INR", "JPY"]

    var tipAmount: Double {
        return billAmount * (tipPercentage / 100)
    }

    var totalAmount: Double {
        return billAmount + tipAmount
    }

    var amountPerPerson: Double {
        return totalAmount / Double(numberOfPeople)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Tip Calculator")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            // Currency Picker
            Picker("Currency", selection: $selectedCurrency) {
                ForEach(currencyOptions, id: \.self) { currency in
                    Text(currency)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Bill Amount Slider
            VStack(alignment: .leading) {
                Text("Bill Amount: \(billAmount, format: .currency(code: selectedCurrency))")
                    .font(.headline)
                Slider(value: $billAmount, in: 0...500, step: 1)
                    .accentColor(.blue)
            }
            .padding()

            // Tip Percentage Slider
            VStack(alignment: .leading) {
                Text("Tip Percentage: \(Int(tipPercentage))%")
                    .font(.headline)
                Slider(value: $tipPercentage, in: 0...30, step: 1)
                    .accentColor(.green)
            }
            .padding()

            // Number of People Slider
            VStack(alignment: .leading) {
                Text("Number of People: \(Int(numberOfPeople))")
                    .font(.headline)
                Slider(value: $numberOfPeople, in: 1...20, step: 1)
                    .accentColor(.orange)
            }
            .padding()

            if showResults {
                VStack(spacing: 10) {
                    Text("Tip Amount: \(tipAmount, format: .currency(code: selectedCurrency))")
                    Text("Total Amount: \(totalAmount, format: .currency(code: selectedCurrency))")
                    Text("Amount Per Person: \(amountPerPerson, format: .currency(code: selectedCurrency))")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .shadow(radius: 5)
            }

            Button(action: {
                showResults.toggle()
            }) {
                Text(showResults ? "Hide Results" : "Calculate")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(showResults ? Color.red : Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 20)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
