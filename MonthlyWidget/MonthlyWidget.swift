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
        DayEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (DayEntry) -> ()) {
        let entry = DayEntry(date: Date())
        completion(entry)
    }
// TODO: add Persian calendar
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            // update start day with first
            let startDay = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startDay)
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
}

struct MonthlyWidgetEntryView : View {
    @Environment(\.showsWidgetContainerBackground) var showContainerBackground
    // rendering mode is for get place of rendering widget
    @Environment(\.widgetRenderingMode) var renderingMode
    var entry: DayEntry
    var config: MonthConfig
    
    init(entry: DayEntry) {
        self.entry = entry
        self.config = MonthConfig.determineConfig(from: entry.date)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                Text(config.emojiText)
                    .font(.title)
                Text(entry.date.weekDayDisplayFormat)
                    .font(.title3)
                    .bold()
                    .minimumScaleFactor(0.6)
                    .foregroundStyle(showContainerBackground ? config.weekdayTextColor : .white)
                Spacer()
            }
            
            Text(entry.date.dayDisplayFormat)
                .font(.system(size: 80,weight: .heavy))
                .foregroundStyle(showContainerBackground ? config.dayTextColor : .white)
                .contentTransition(.numericText())
        }
        .containerBackground(for: .widget) {
            ContainerRelativeShape()
                .fill(config.backgroundColor.gradient)
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
//        .contentMarginsDisabled()
        .configurationDisplayName("Monthly Style Widget")
        .description("The theme of the widget changes based on month.")
        // use for what size you use
        .supportedFamilies([.systemSmall])
        // place of "not" use widgets for each size
//        .disfavoredLocations([.homeScreen,.lockScreen], for: [.systemLarge])
    }
}

#Preview(as: .systemSmall) {
    MonthlyWidget()
} timeline: {
    MockData.dayOne
    MockData.dayTwo
    MockData.dayThree
    MockData.dayFour
}

extension Date {
    var weekDayDisplayFormat: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    var dayDisplayFormat: String {
        self.formatted(.dateTime.day())
    }
}

struct MockData {
    static let dayOne = DayEntry(date: dateToDisplay(month: 11, day: 4))
    static let dayTwo = DayEntry(date: dateToDisplay(month: 2, day: 5))
    static let dayThree = DayEntry(date: dateToDisplay(month: 10, day: 6))
    static let dayFour = DayEntry(date: dateToDisplay(month: 12, day: 7))
    
    static func dateToDisplay(month: Int, day: Int) -> Date {
        let components = DateComponents(calendar: Calendar.current,
                                        year: 2022,
                                        month: month,
                                        day: day)
        return Calendar.current.date(from: components)!
    }
}
