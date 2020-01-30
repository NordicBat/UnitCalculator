//
//  ContentView.swift
//  UnitCalculator
//
//  Created by Gabriel Meira on 30.01.20.
//  Copyright © 2020 Gabriel Meira. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var userUnit = ""
    @State private var unitsFrom = 1
    @State private var unitsTo = 1

    private var units = ["cm", "m", "km", "yrds", "miles"]

    private var convertedUnit: Double {
        let userImput = Double(userUnit) ?? 0
        let initialValue: Measurement<UnitLength>

        switch unitsFrom {
        case 1:
            initialValue = Measurement(value: userImput, unit: UnitLength.meters)
        case 2:
            initialValue = Measurement(value: userImput, unit: UnitLength.kilometers)
        case 3:
            initialValue = Measurement(value: userImput, unit: UnitLength.yards)
        case 4:
            initialValue = Measurement(value: userImput, unit: UnitLength.miles)
        default:
            initialValue = Measurement(value: userImput, unit: UnitLength.centimeters)
        }

        switch unitsTo {
        case 1:
            return initialValue.converted(to: .meters).value
        case 2:
            return initialValue.converted(to: .kilometers).value
        case 3:
            return initialValue.converted(to: .yards).value
        case 4:
            return initialValue.converted(to: .miles).value
        default:
            return initialValue.converted(to: .centimeters).value
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Value to be converted", text: $userUnit)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("From Unit")) {
                    Picker("From Unit", selection: $unitsFrom) {
                        ForEach(units.indices) {
                            Text(self.units[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("To Unit")) {
                    Picker("To Unit", selection: $unitsTo) {
                        ForEach(units.indices) {
                            Text(self.units[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Converted Unit")) {
                    Text("\( convertedUnit, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Unit Converter")
        }
        .colorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
