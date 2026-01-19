import SwiftUI

struct ContentView: View {
    @StateObject private var yearProgress = YearProgressCalculator()

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.4, green: 0.3, blue: 0.3), Color(red: 0.2, green: 0.15, blue: 0.15)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Text("one year")
                    .font(.system(size: 34, weight: .medium))
                    .foregroundColor(.white)

                YearProgressView(
                    totalDays: yearProgress.totalDays,
                    currentDay: yearProgress.currentDay
                )
                .frame(width: 350, height: 350)
                .background(
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color.black)
                        .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)
                )

                VStack(spacing: 10) {
                    Text("Day \(yearProgress.currentDay) of \(yearProgress.totalDays)")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)

                    Text("\(yearProgress.percentComplete, specifier: "%.1f")% complete")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.7))

                    Text("\(yearProgress.daysRemaining) days remaining")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.7))
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
