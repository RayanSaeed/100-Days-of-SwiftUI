//
//  ContentView.swift
//  WeSplit
//
//  Created by Rayan Saeed on 17/04/2022.
//

import SwiftUI

struct ContentView: View {

	@State private var checkAmount = 0.0
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 20
	@FocusState private var amountIsFocused: Bool

	// let tipPercentages = [0, 10, 15, 20, 25]

	let currencyFormatter:
	FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")

	var totalPerPerson: Double {
		let peopleCount = Double(numberOfPeople + 2)
		let tipSelection = Double(tipPercentage)

		let tipValue = checkAmount / 100 * tipSelection
		let grandTotal = checkAmount + tipValue
		let amountPerPerson = grandTotal / peopleCount

		return amountPerPerson
	}

	var totalCheckAmountkWithTip: Double {
		let peopleCount = Double(numberOfPeople + 2)
		return totalPerPerson * peopleCount
	}

	var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Amount", value: $checkAmount, format:
							.currency(code: Locale.current.currencyCode ?? "USD"))
							.keyboardType(.decimalPad)
							.focused($amountIsFocused)

					Picker("Number of people", selection: $numberOfPeople) {
						ForEach(2..<99) {
							Text("\($0) people")
						}
					}
				}

				/*
				/// Segmented Picker Style

				Section {
					Picker("Tip percentage", selection: $tipPercentage) {
						ForEach(tipPercentages, id: \.self) {
							Text($0, format: .percent)
						}
					}
					.pickerStyle(.segmented)
				} header: {
					Text("How much tip do you want to leave?")
				}
				*/

				Section {
					Picker("Tip percentage", selection: $tipPercentage) {
						ForEach(0..<101, id: \.self) {
							Text($0, format: .percent)
						}
					}
				} header: {
					Text("How much tip do you want to leave?")
				}

				Section {
					Text(totalPerPerson, format: currencyFormatter)
				} header: {
					Text("Amount per person")
				}

				Section {
					Text(totalCheckAmountkWithTip, format: currencyFormatter)
				} header: {
					Text("Total amount of check")
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
