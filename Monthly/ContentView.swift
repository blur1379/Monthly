//
//  ContentView.swift
//  Monthly
//
//  Created by Mohammad Blur on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Image(systemName: "calendar")
                .imageScale(.large)
            
            Text(Date().dayDisplayFormat)
                .font(.largeTitle)
               
        }
        .bold()
        .foregroundStyle(Color(.label).opacity(0.5))
        .padding()
    }
}

#Preview {
    ContentView()
}

extension Date {
    var weekDayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day())
    }
}
