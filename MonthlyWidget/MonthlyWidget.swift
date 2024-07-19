//
//  MonthlyWidget.swift
//  MonthlyWidget
//
//  Created by Mohammad Blur on 7/2/24.
//

import WidgetKit
import SwiftUI
import AppIntents

struct Provider: AppIntentTimelineProvider {
    
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date(), showFunFont: false)
    }
    
    func snapshot(for configuration: ChangeFontIntent, in context: Context) async -> DayEntry {
        let entry = DayEntry(date: Date(), showFunFont: false)
        return entry
    }
    
    func timeline(for configuration: ChangeFontIntent, in context: Context) async -> Timeline<DayEntry> {
        let showFunFont = configuration.funFont
        
        var entries: [DayEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            // update start day with first
            let startDay = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startDay, showFunFont: showFunFont)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        return timeline
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
    let showFunFont: Bool
}

struct MonthlyWidgetEntryView : View {
    @Environment(\.showsWidgetContainerBackground) var showContainerBackground
    // rendering mode is for get place of rendering widget
    @Environment(\.widgetRenderingMode) var renderingMode
    var entry: DayEntry
    var config: MonthConfig
    var funFontName: String = "Chalkduster"
    
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
                    .font(entry.showFunFont ? .custom(funFontName, size: 24) : .title3)
                    .bold()
                    .minimumScaleFactor(0.6)
                    .foregroundStyle(showContainerBackground ? config.weekdayTextColor : .white)
                Spacer()
            }
            .id(entry.date)
            .transition(.push(from: .trailing))
            .animation(.bouncy, value: entry.date)
            Text(entry.date.dayDisplayFormat)
                .font(entry.showFunFont ? .custom(funFontName, size: 80) : .system(size: 80,weight: .heavy))
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
        
        AppIntentConfiguration(kind: kind, intent: ChangeFontIntent.self, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MonthlyWidgetEntryView(entry: entry)
                   
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

struct ChangeFontIntent: AppIntent, WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Fun Font"
    static var description: IntentDescription = IntentDescription(stringLiteral: "Switch to a fun Font")
    
    @Parameter(title: "Func font")
    var funFont: Bool
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
    static let dayOne = DayEntry(date: dateToDisplay(month: 11, day: 4), showFunFont: true)
    static let dayTwo = DayEntry(date: dateToDisplay(month: 2, day: 5), showFunFont: false)
    static let dayThree = DayEntry(date: dateToDisplay(month: 10, day: 6), showFunFont: false)
    static let dayFour = DayEntry(date: dateToDisplay(month: 12, day: 7), showFunFont: false)
    
    static func dateToDisplay(month: Int, day: Int) -> Date {
        let components = DateComponents(calendar: Calendar.current,
                                        year: 2022,
                                        month: month,
                                        day: day)
        return Calendar.current.date(from: components)!
    }
}
