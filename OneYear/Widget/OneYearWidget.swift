import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> YearProgressEntry {
        YearProgressEntry(date: Date(), progress: YearProgress.current())
    }

    func getSnapshot(in context: Context, completion: @escaping (YearProgressEntry) -> Void) {
        let entry = YearProgressEntry(date: Date(), progress: YearProgress.current())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<YearProgressEntry>) -> Void) {
        let currentDate = Date()
        let progress = YearProgress.current()
        let entry = YearProgressEntry(date: currentDate, progress: progress)

        // Update at midnight
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        let midnight = calendar.startOfDay(for: tomorrow)

        let timeline = Timeline(entries: [entry], policy: .after(midnight))
        completion(timeline)
    }
}

struct YearProgressEntry: TimelineEntry {
    let date: Date
    let progress: YearProgress
}

struct OneYearWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        VStack(spacing: widgetFamily == .systemSmall ? 8 : 12) {
            YearProgressView(
                totalDays: entry.progress.totalDays,
                currentDay: entry.progress.currentDay
            )
            .padding(widgetFamily == .systemSmall ? 12 : 16)

            Text("one year")
                .font(.system(size: widgetFamily == .systemSmall ? 12 : 16, weight: .medium))
                .foregroundColor(.white)
                .padding(.bottom, 8)
        }
        .containerBackground(for: .widget) {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.4, green: 0.3, blue: 0.3), Color(red: 0.2, green: 0.15, blue: 0.15)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}

@main
struct OneYearWidget: Widget {
    let kind: String = "OneYearWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            OneYearWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("One Year")
        .description("Track your progress through the year with dots.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct OneYearWidget_Previews: PreviewProvider {
    static var previews: some View {
        OneYearWidgetEntryView(entry: YearProgressEntry(date: Date(), progress: YearProgress.current()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
