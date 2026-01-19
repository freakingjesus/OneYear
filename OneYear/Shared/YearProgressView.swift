import SwiftUI

struct YearProgressView: View {
    let totalDays: Int
    let currentDay: Int

    private let columns = 19
    private let dotSize: CGFloat = 5
    private let spacing: CGFloat = 8

    var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.size.width - 40
            let actualDotSize = min(dotSize, (availableWidth - CGFloat(columns - 1) * spacing) / CGFloat(columns))

            VStack(spacing: spacing) {
                ForEach(0..<rows, id: \.self) { row in
                    HStack(spacing: spacing) {
                        ForEach(0..<columns, id: \.self) { column in
                            let dayIndex = row * columns + column + 1
                            DotView(
                                isLit: dayIndex <= currentDay,
                                size: actualDotSize
                            )
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(20)
        }
    }

    private var rows: Int {
        Int(ceil(Double(totalDays) / Double(columns)))
    }
}

struct DotView: View {
    let isLit: Bool
    let size: CGFloat

    var body: some View {
        Circle()
            .fill(isLit ? Color.white : Color.white.opacity(0.15))
            .frame(width: size, height: size)
            .shadow(color: isLit ? .white.opacity(0.3) : .clear, radius: 2, x: 0, y: 0)
    }
}

struct YearProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            YearProgressView(totalDays: 365, currentDay: 9)
                .frame(width: 350, height: 350)
        }
    }
}
