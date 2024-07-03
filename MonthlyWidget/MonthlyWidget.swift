//
//  MonthlyWidget.swift
//  MonthlyWidget
//
//  Created by Mohammad Blur on 7/2/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (DayEntry) -> ()) {
        let entry = DayEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startDay = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startDay, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct MonthlyWidgetEntryView : View {
    var entry: DayEntry

    var body: some View {
        ZStack {
            ContainerRelativeShape()
                .fill(.gray.gradient)
            VStack {
                HStack(spacing: 4) {
                    Text("⛄️")
                        .font(.title)
                    Text(entry.date.weekDayDisplayFormat)
                        .font(.title3)
                        .bold()
                        .minimumScaleFactor(0.6)
                        .foregroundColor(.black.opacity(0.6))
                    Spacer()
                }
                
                Text(entry.date.dayDisplayFormat)
                    .font(.system(size: 80,weight: .heavy))
                    .foregroundStyle(Color.white.opacity(0.8))
            }
            .padding()
        }
    }
}

struct MonthlyWidget: Widget {
    let kind: String = "MonthlyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MonthlyWidgetEntryView(entry: entry)
                    
                    .containerBackground(.fill.tertiary, for: .widget)
                   
            } else {
                MonthlyWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .contentMarginsDisabled()
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    MonthlyWidget()
} timeline: {
    DayEntry(date: .now, emoji: "😀")
    DayEntry(date: .now, emoji: "🤩")
}

extension Date {
    var weekDayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day())
    }
}
