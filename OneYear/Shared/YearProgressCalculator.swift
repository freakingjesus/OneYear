import Foundation
import Combine

class YearProgressCalculator: ObservableObject {
    @Published var currentDay: Int = 1
    @Published var totalDays: Int = 365
    @Published var percentComplete: Double = 0
    @Published var daysRemaining: Int = 0

    private var timer: Timer?

    init() {
        calculateProgress()
        setupTimer()
    }

    private func setupTimer() {
        // Update at midnight each day
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.calculateProgress()
        }
    }

    func calculateProgress() {
        let calendar = Calendar.current
        let now = Date()
        let year = calendar.component(.year, from: now)

        // Get the first day of the year
        guard let startOfYear = calendar.date(from: DateComponents(year: year, month: 1, day: 1)) else {
            return
        }

        // Calculate total days in the year
        let isLeapYear = calendar.range(of: .day, in: .year, for: now)?.count ?? 365
        totalDays = isLeapYear

        // Calculate current day of the year
        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: now) ?? 1
        currentDay = dayOfYear

        // Calculate percent complete
        percentComplete = (Double(currentDay) / Double(totalDays)) * 100

        // Calculate days remaining
        daysRemaining = totalDays - currentDay

        print("Year progress: Day \(currentDay) of \(totalDays)")
    }

    deinit {
        timer?.invalidate()
    }
}

// Helper for widgets to get current progress without ObservableObject
struct YearProgress {
    let currentDay: Int
    let totalDays: Int
    let percentComplete: Double
    let daysRemaining: Int

    static func current() -> YearProgress {
        let calendar = Calendar.current
        let now = Date()
        let year = calendar.component(.year, from: now)

        guard let startOfYear = calendar.date(from: DateComponents(year: year, month: 1, day: 1)) else {
            return YearProgress(currentDay: 1, totalDays: 365, percentComplete: 0, daysRemaining: 365)
        }

        let totalDays = calendar.range(of: .day, in: .year, for: now)?.count ?? 365
        let currentDay = calendar.ordinality(of: .day, in: .year, for: now) ?? 1
        let percentComplete = (Double(currentDay) / Double(totalDays)) * 100
        let daysRemaining = totalDays - currentDay

        return YearProgress(
            currentDay: currentDay,
            totalDays: totalDays,
            percentComplete: percentComplete,
            daysRemaining: daysRemaining
        )
    }
}
