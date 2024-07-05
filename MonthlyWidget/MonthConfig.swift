//
//  MonthConfig.swift
//  Monthly
//
//  Created by Mohammad Blur on 7/5/24.
//

import SwiftUI

struct MonthConfig {
    let backgroundColor: Color
    let emojiText: String
    let weekdayTextColor: Color
    let dayTextColor: Color

    static func determineConfig(from date: Date) -> MonthConfig {
        let monthInt = Calendar.current.component(.month, from: date)

        switch monthInt {
        case 1:
            return MonthConfig(backgroundColor: Color.gray,
                               emojiText: "⛄️",
                               weekdayTextColor: Color.black.opacity(0.6),
                               dayTextColor: Color.white.opacity(0.8))
        case 2:
            return MonthConfig(backgroundColor: Color.palePink,
                               emojiText: "❤️",
                               weekdayTextColor: Color.black.opacity(0.5),
                               dayTextColor: Color.pink.opacity(0.8))
        case 3:
            return MonthConfig(backgroundColor: Color.paleGreen,
                               emojiText: "☘️",
                               weekdayTextColor: Color.black.opacity(0.7),
                               dayTextColor: Color.darkGreen.opacity(0.8))
        case 4:
            return MonthConfig(backgroundColor: .paleBlue,
                               emojiText: "☔️",
                               weekdayTextColor: Color.black.opacity(0.5),
                               dayTextColor: Color.purple.opacity(0.8))
        case 5:
            return MonthConfig(backgroundColor: Color.paleYellow,
                               emojiText: "🌺",
                               weekdayTextColor: Color.black.opacity(0.5),
                               dayTextColor: Color.pink.opacity(0.7))
        case 6:
            return MonthConfig(backgroundColor: Color.skyBlue,
                               emojiText: "🌤",
                               weekdayTextColor: Color.black.opacity(0.5),
                               dayTextColor: Color.paleYellow.opacity(0.8))
        case 7:
            return MonthConfig(backgroundColor: Color.blue,
                               emojiText: "🏖",
                               weekdayTextColor: Color.black.opacity(0.5),
                               dayTextColor: .paleBlue.opacity(0.8))
        case 8:
            return MonthConfig(backgroundColor: Color.paleOrange,
                               emojiText: "☀️",
                               weekdayTextColor: Color.black.opacity(0.5),
                               dayTextColor: Color.darkOrange.opacity(0.8))
        case 9:
            return MonthConfig(backgroundColor: Color.paleRed,
                               emojiText: "🍁",
                               weekdayTextColor: Color.black.opacity(0.5),
                               dayTextColor: Color.paleYellow.opacity(0.9))
        case 10:
            return MonthConfig(backgroundColor: Color.black,
                               emojiText: "👻",
                               weekdayTextColor: Color.white.opacity(0.6),
                               dayTextColor: Color.orange.opacity(0.8))
        case 11:
            return MonthConfig(backgroundColor: Color.paleBrown,
                               emojiText: "🦃",
                               weekdayTextColor: Color.black.opacity(0.6),
                               dayTextColor: Color.black.opacity(0.6))
        case 12:
            return MonthConfig(backgroundColor: Color.paleRed,
                               emojiText: "🎄",
                               weekdayTextColor: Color.white.opacity(0.9),
                               dayTextColor: Color.darkGreen.opacity(0.7))
        default:
            return MonthConfig(backgroundColor: Color.gray,
                               emojiText: "📅",
                               weekdayTextColor: Color.black.opacity(0.6),
                               dayTextColor: Color.white.opacity(0.8))
        }
    }
}
