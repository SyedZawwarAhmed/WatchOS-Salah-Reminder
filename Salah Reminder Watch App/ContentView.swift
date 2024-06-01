//
//  ContentView.swift
//  Salah Reminder Watch App
//
//  Created by Zawwar Ahmed on 06/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State var prayers: [[String: String]] = [
        ["name": "Fajr", "time": "05:30"],
        ["name": "Zuhur", "time": "13:30"],
        ["name":"Asr", "time":"17:45"],
        ["name": "Maghrib", "time":"19:05"],
        ["name":"Isha", "time": "21:00"]
]
    
    @State var selectedPrayerIndex = -1
    @State var selectedTime = Date()
    
    var body: some View {
        List {
            ForEach(prayers.indices, id: \.self) { index in
                Button(action: {
                    // Open time picker when the button is tapped
                    selectedPrayerIndex = index
                    // Show the time picker
                }) {
                    HStack {
                        Text(prayers[index]["name"] ?? "")
                        Spacer()
                        Text(prayers[index]["time"] ?? "")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
                .sheet(isPresented: .constant(selectedPrayerIndex == index)) {
                    TimePickerView(selectedTime: $selectedTime, prayerIndex: index, prayers: $prayers, selectedPrayerIndex: $selectedPrayerIndex)
                }
            }
        }
    }
}

struct TimePickerView: View {
    @Binding var selectedTime: Date
    let prayerIndex: Int
    @Binding var prayers: [[String: String]]
    @Binding var selectedPrayerIndex: Int

    var body: some View {
        VStack {
            DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
            Button(action: {
                // Update the prayer time when the "Done" button is tapped
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                prayers[prayerIndex]["time"] = dateFormatter.string(from: selectedTime)
                selectedPrayerIndex = -1
                
            }) {
                Text("Done")
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
